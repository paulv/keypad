require 'device_input'
require 'pry'
require 'yaml'
require './ffi.rb'
require './commands.rb'

version = %x(git log --pretty=format:"%h"  -1)

puts "version: #{version}"

DEVICE = "/dev/input/by-id/usb-04d9_1203-event-kbd"
command_map = YAML.load_file "config.yaml"

device = File.open(DEVICE, "r")
device.ioctl(EVIOCGRAB, 1)

commands = Commands.new

loop {
  bytes = device.read(DeviceInput::Event::BYTE_LENGTH)
  break unless (bytes and bytes.length == DeviceInput::Event::BYTE_LENGTH)

  decoded_data = DeviceInput::Event.decode(bytes)
  data = DeviceInput::Event.new(decoded_data)
  if data.type == "EV_KEY"
    begin
      if data.value == 0
        command = command_map[data.code.downcase]
        commands.send(command)
      end
    rescue NoMethodError => e
      puts "No method named #{data.code.downcase} yet"
    end
  end
}
