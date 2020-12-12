require 'ostruct'
require 'pry'

inputs = File.read('inputs.txt').split("\n")

class Array
  alias_method :x, :first
  alias_method :y, :last
end

@direction = OpenStruct.new(
  :neutral => [0, 0],
  :up => [0, 1],
  :down => [0, -1],
  :left => [-1, 0],
  :right => [1, 0],
  :upper_left => [-1, -1],
  :lower_left => [-1, 1],
  :upper_right => [1, -1],
  :lower_right => [1, 1],
)

class Seat
  attr_accessor :occupied
  attr_reader :x, :y, :type

  def initialize(input, x, y)
    @x = x
    @y = y

    input == '#' ? @occupied = true : @occupied = false
    if input == 'L' || input == '#'
      @type = :seat
    else
      @type = :floor
    end
  end
end

def retrieve_seat(origin_x, origin_y, direction, room)
  x = origin_x
  y = origin_y

  return nil if x < 0 || x >= room.first.size
  return nil if y < 0 || y >= room.size
  return room[y][x] if direction == [0, 0]

  until room[y][x].type == :seat && room[y][x] != room[origin_y][origin_x]
    x += direction.x
    y += direction.y

    return nil if x < 0 || x >= room.first.size
    return nil if y < 0 || y >= room.size
  end

  room[y][x]
end

def retrieve_adjacent_seats(seat, room)
  origin_x = seat.x
  origin_y = seat.y

  [
    retrieve_seat(origin_x, origin_y, @direction.upper_left,  room),
    retrieve_seat(origin_x, origin_y, @direction.up,          room),
    retrieve_seat(origin_x, origin_y, @direction.upper_right, room),
    retrieve_seat(origin_x, origin_y, @direction.left,        room),
    retrieve_seat(origin_x, origin_y, @direction.neutral,     room),
    retrieve_seat(origin_x, origin_y, @direction.right,       room),
    retrieve_seat(origin_x, origin_y, @direction.lower_left,  room),
    retrieve_seat(origin_x, origin_y, @direction.down,        room),
    retrieve_seat(origin_x, origin_y, @direction.lower_right, room)
  ]
end

def five_or_more_adjacent_seat_occupied?(adjacent_seats)
  adjacent_seats.count { |seat| seat&.occupied } > 5
end

def not_any_adjacent_seat_occupied?(adjacent_seats)
  adjacent_seats.count { |seat| seat&.occupied } == 0
end

initial_room = inputs.enum_for(:each_with_index).map do |row, y|
  row.split('').enum_for(:each_with_index).map do |input, x|
    if input == 'L' || input == '#'
      type = :seat
    else
      type = :floor
    end

    Seat.new(input, x, y)
  end.flatten
end

def draw(room)
  room.each do |row|
    string = ''
    row.each do |seat|

      if seat.occupied && seat.type == :seat
        string += '#'
      elsif !seat.occupied && seat.type == :seat
        string += 'L'
      elsif seat.type == :floor
        string += '0'
      end
    end
    p string
  end
  nil
end

tmp_room = Marshal.load(Marshal.dump(initial_room))

loop do
  initial_room = Marshal.load(Marshal.dump(tmp_room))

  initial_room.each_with_index do |row, y|
    row.each_with_index do |seat, x|

      if seat.type == :seat && five_or_more_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
        tmp_room[y][x].occupied = false
      elsif seat.type == :seat && not_any_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
        tmp_room[y][x].occupied = true
      end
    end
  end

  p '|-------------------------|'
  draw(initial_room)
  p '|-------------------------|'
  p "Occupied seats : #{tmp_room.flatten.count { |seat| seat&.occupied }}"
  sleep(1)
end
