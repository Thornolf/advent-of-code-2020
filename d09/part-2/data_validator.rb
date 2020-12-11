inputs = File.read('inputs.txt').split("\n").map(&:to_i)

inputs.each_with_index do |input, index|
  range = inputs[index..inputs.size]
  filler = []

  range.each do |r|
    filler << r
    p "#{filler.sort.first + filler.sort.last}" if filler.sum == 15690279 && filler.size > 1
  end
end
