require 'pry'
require 'ostruct'

inputs = File.read('inputs.txt').split("\n")


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

def retrieve_seat(origin_x, origin_y, room)
  return nil if origin_x < 0 || origin_x >= room.first.size
  return nil if origin_y < 0 || origin_y >= room.size

  room[origin_y][origin_x]
end

def retrieve_adjacent_seats(seat, room)
  origin_x = seat.x
  origin_y = seat.y

  [
    retrieve_seat(origin_x - 1, origin_y - 1, room), retrieve_seat(origin_x, origin_y - 1, room), retrieve_seat(origin_x + 1, origin_y - 1, room),
    retrieve_seat(origin_x - 1, origin_y, room), retrieve_seat(origin_x, origin_y, room), retrieve_seat(origin_x + 1, origin_y, room),
    retrieve_seat(origin_x - 1, origin_y + 1, room), retrieve_seat(origin_x, origin_y + 1, room), retrieve_seat(origin_x + 1, origin_y + 1, room)
  ]
end

def four_or_more_adjacent_seat_occupied?(adjacent_seats)
  adjacent_seats.count { |seat| seat&.occupied } > 4
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

initial_room.each_with_index do |row, y|
  row.each_with_index do |seat, x|
    if seat.type == :seat && four_or_more_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = false
    elsif seat.type == :seat && not_any_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = true
    end
  end
end

draw(initial_room)

p '--- --- --- --- --- --- ---'

initial_room = Marshal.load(Marshal.dump(tmp_room))

initial_room.each_with_index do |row, y|
  row.each_with_index do |seat, x|
    binding.pry if y > 0
    if seat.type == :seat && four_or_more_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = false
    elsif seat.type == :seat && not_any_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = true
    end
  end
end

draw(initial_room)

p '--- --- --- --- --- --- ---'


initial_room = Marshal.load(Marshal.dump(tmp_room))

initial_room.each_with_index do |row, y|
  row.each_with_index do |seat, x|
    if seat.type == :seat && four_or_more_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = false
    elsif seat.type == :seat && not_any_adjacent_seat_occupied?(retrieve_adjacent_seats(seat, initial_room))
      tmp_room[y][x].occupied = true
    end
  end
end


draw(initial_room)

