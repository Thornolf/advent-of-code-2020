values = File.read('values.txt').split(',').map(&:to_i)

values.each do |first_value|
  values.each do |second_value|
    values.each {|third_value| p "#{first_value * second_value * third_value}" if first_value + second_value + third_value == 2020 && [first_value, second_value, third_value].uniq.count == 3 }
  end
end
