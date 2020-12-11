inputs = File.read('inputs.txt').split("\n").map(&:to_i)

inputs.each_with_index do |input, index|
  next if index < 25

  range = inputs[(index - 25)...(index)]
  valid = false

  range.each do |number|
    range.each do |n|
      if (number + n) == inputs[index] && number != n
        valid = true
      end
    end
  end

  unless valid
    p "inputs[#{index}] = #{inputs[index]} is the corrupted number"
    return
  end
end
