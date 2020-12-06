answers = File.read('answers.txt').split("\n\n")

result = answers.reduce(0) do |s, answer|
  answer = answer.split("\n")
  witness_row = answer.first
  answer.shift

  witness_row.split('').reduce(s) { |sum, witness| answer.all? { |a| a.include?(witness) } ? sum += 1 : sum }
end

p result