require 'ostruct'

inputs = File.read('inputs.txt').split("\n")

@compass = %w(south west north east)
@waypoint = OpenStruct.new(:facing => @compass.last, :x => 10, :y => 1)

# east & west => x || north & south => y

def forward_to_the_waypoint(ship, multiplicator)
  ship.x += multiplicator * @waypoint.x
  ship.y += multiplicator * @waypoint.y

  ship
end

def move_waypoint_to_specific_cap( unit, instruction)
  if instruction == 'E'
    @waypoint.x += unit
  elsif instruction == 'S'
    @waypoint.y -= unit
  elsif instruction == 'W'
    @waypoint.x -= unit
  elsif instruction == 'N'
    @waypoint.y += unit
  end
end

def rotate_waypoint(ship, value, direction)
  new_index = value / 90

  until 0 >= new_index
    if direction == 'R'
      @waypoint.x, @waypoint.y = @waypoint.y, -@waypoint.x
    else
      @waypoint.x, @waypoint.y = -@waypoint.y, @waypoint.x
    end
    new_index -= 1
  end
end

ship = OpenStruct.new(:facing => @compass.last, :x => 0, :y => 0)

instructions = inputs.map do |input|
  action, value = input.split('', 2)

  OpenStruct.new(:action => action, :value => value.to_i)
end

instructions.each do |instruction|
  if instruction.action == 'F'
    ship = forward_to_the_waypoint(ship, instruction.value)
  elsif %w(R L).include?(instruction.action)
    rotate_waypoint(ship, instruction.value, instruction.action)
  elsif %w(N E S W).include?(instruction.action)
    move_waypoint_to_specific_cap(instruction.value, instruction.action)
  end
end

p ship.x
p ship.y
