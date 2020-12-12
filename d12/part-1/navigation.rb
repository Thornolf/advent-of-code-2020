require 'pry'
require 'ostruct'

inputs = File.read('inputs.txt').split("\n")

@compass = %w(south west north east)

# east & west => x || north & south => y

def move_ship_to_specific_cap(ship, unit, instruction)
  if instruction == 'E'
    ship.x += unit
  elsif instruction == 'S'
    ship.y -= unit
  elsif instruction == 'W'
    ship.x -= unit
  elsif instruction == 'N'
    ship.y += unit
  end

  ship
end

def move_ship_forward(ship, unit)
  if ship.facing == 'east'
    ship.x += unit
  elsif ship.facing == 'south'
    ship.y -= unit
  elsif ship.facing == 'west'
    ship.x -= unit
  elsif ship.facing == 'north'
    ship.y += unit
  end

  ship
end

def rotate_ship(ship, value, direction)
  index = @compass.find_index(ship.facing)
  new_index = value / 90
  direction == 'R' ? d = 1 : d = -1

  until 0 >= new_index
    index += d
    index = 0 if index >= @compass.size
    new_index -= 1
  end
  ship.facing = @compass[index]

  ship
end

ship = OpenStruct.new(:facing => @compass.last, :x => 0, :y => 0)

instructions = inputs.map do |input|
  action, value = input.split('', 2)

  OpenStruct.new(:action => action, :value => value.to_i)
end

instructions.each do |instruction|
  if instruction.action == 'F'
    ship = move_ship_forward(ship, instruction.value)
  elsif %w(R L).include?(instruction.action)
    ship = rotate_ship(ship, instruction.value, instruction.action)
  elsif %w(N E S W).include?(instruction.action)
    ship = move_ship_to_specific_cap(ship, instruction.value, instruction.action)
  end
end

p ship.x
p ship.y