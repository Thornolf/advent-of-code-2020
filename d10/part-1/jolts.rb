require 'pry'
inputs = File.read('inputs.txt').split("\n").map(&:to_i).sort

one_jolts = 0
three_jolts = 0
inputs.each_with_index do |input, index|
  if index.zero?
    inputs[index + 1] == input += 1 ? one_jolts += 1 : three_jolts += 1
  end

  if inputs[index - 1] + 1 == input
    one_jolts += 1
  elsif inputs[index - 1] + 3 == input
    three_jolts += 1
  end
end

p (three_jolts + 1) * one_jolts