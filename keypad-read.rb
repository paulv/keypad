require 'device_input'
require 'pry'
require './ffi.rb'
require './commands.rb'

DEVICE = "/dev/input/by-id/usb-04d9_1203-event-kbd"

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
      commands.send(data.code.downcase) if data.value == 0
    rescue NoMethodError => e
      puts "No method named #{data.code.downcase} yet"
    end
  end
}
