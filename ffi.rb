require 'ffi'
require 'ffi/tools/const_generator'

cg = FFI::ConstGenerator.new('input') do |gen|
  gen.include('linux/input.h')
  gen.const(:EVIOCGRAB, '%u', '(unsigned)')
end

EVIOCGRAB = cg['EVIOCGRAB'].to_i
