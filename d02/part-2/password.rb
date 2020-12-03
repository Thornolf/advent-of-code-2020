values = File.read('values.txt').split("\n")

values.reject! do |value|
  matcher = 0
  first, second, key, string = value.split /\s|-|,/

  matcher += 1 if string[first.to_i - 1] == key.delete!(':')
  matcher += 1 if string[second.to_i - 1] == key
  matcher != 1
end

p values.count
