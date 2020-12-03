require "ostruct"

values = File.read('values.txt').split("\n")

values.reject! do |value|
  size, key, string = value.split(' ')
  min, max = size.split('-').map(&:to_i)
  !string.delete("^#{key}").size.between?(min, max)
end

p values.count
