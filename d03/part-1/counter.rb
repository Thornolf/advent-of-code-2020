require 'pry'

map = File.read('map.txt').split("\n")

trees_count = 0
row = 0
column = 0

until column >= map.size
  if row >= map[column].size
    row = row - map[column].size
  end
  trees_count += 1 if map[column][row] == '#'

  column += 1
  row += 3
end

p trees_count
