require 'ostruct'
require 'pry'

inputs = File.read('inputs.txt').split("\n").map do |input|
  instruction, value = input.split(' ')
  OpenStruct.new(:instruction => instruction, :value => value.to_i, :used => false)
end

index = 0
accumulator = 0

loop do
  break if inputs[index].used == true

  if inputs[index].instruction == 'acc'
    inputs[index].used = true
    accumulator += inputs[index].value
    index += 1
  elsif inputs[index].instruction == 'jmp'
    index += inputs[index].value
  else
    index += 1
  end

end

p accumulator

