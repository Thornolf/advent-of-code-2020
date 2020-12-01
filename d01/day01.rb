values = File.read('values.txt').split(',').map(&:to_i)

values.each do |value|
  values.each {|v| p "#{v * value}" if value + v == 2020 && value != v }
end
