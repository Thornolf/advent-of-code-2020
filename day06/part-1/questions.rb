p File.read('answers.txt').split("\n\n").reduce(0) { |s, answer| s + answer.delete("\n").split('').uniq.flatten.size }