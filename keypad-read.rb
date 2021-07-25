require 'device_input'
require 'pry'
require './ffi.rb'

DEVICE = "/dev/input/by-id/usb-04d9_1203-event-kbd"

device = File.open(DEVICE, "r")
device.ioctl(EVIOCGRAB, 1)

puts DeviceInput::Event::BYTE_LENGTH

io = device

loop {
  bytes = io.read(DeviceInput::Event::BYTE_LENGTH)
  break unless (bytes and bytes.length == DeviceInput::Event::BYTE_LENGTH)

  decoded_data = DeviceInput::Event.decode(bytes)
  data = DeviceInput::Event.new(decoded_data)
  if data.type == "EV_KEY"
    puts "keyup on #{data.code}" if data.value == 0
    puts "keydown on #{data.code}" if data.value == 1
  end
}
