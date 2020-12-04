require 'pry'

def slope_finder(right, down)
  column = 0
  row = 0
  trees_count = 0

  map = File.read('map.txt').split("\n")
  until column >= map.size
    if row >= map[column].size
      row = row - map[column].size
    end
    trees_count += 1 if map[column][row] == '#'

    column += down
    row += right
  end

  trees_count
end

first_slope = slope_finder(1, 1)
second_slope = slope_finder(3, 1)
third_slope = slope_finder(5, 1)
fourth_slope = slope_finder(7, 1)
fifth_slope = slope_finder(1, 2)

p first_slope * second_slope * third_slope * fourth_slope * fifth_slope
