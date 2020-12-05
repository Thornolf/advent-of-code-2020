boarding_passes = File.read('boarding_passes.txt').split("\n")

def boarding_pass_id_finder(boarding_pass)
  seat_region = 0..127
  seat_row = 0..7

  boarding_pass.split('').each do |section|
    case section
    when 'F'
      seat_region = seat_region.first..seat_region.to_a[((seat_region.size - 1) / 2)]
    when 'B'
      seat_region = seat_region.to_a[(seat_region.size / 2)]..seat_region.last
    when 'L'
      seat_row = seat_row.first..seat_row.to_a[((seat_row.size - 1) / 2)]
    when 'R'
      seat_row = seat_row.to_a[(seat_row.size / 2)]..seat_row.last
    else
      p 'Something went wrong'
    end
  end

  seat_region.first * 8 + seat_row.first
end

boarding_pass_ids = []
boarding_passes.each { |boarding_pass| boarding_pass_ids << boarding_pass_id_finder(boarding_pass) }

valid_ids = []

boarding_pass_ids.each do |boarding_pass_id|
  boarding_pass_ids.each do |boarding_pass_neighbour_id|
    if boarding_pass_id == boarding_pass_neighbour_id + 2
      valid_ids << boarding_pass_neighbour_id + 1
    elsif boarding_pass_id == boarding_pass_neighbour_id - 2
      valid_ids << boarding_pass_neighbour_id - 1
    end
  end
end

boarding_pass_ids = boarding_pass_ids.sort
boarding_pass_ids.pop
boarding_pass_ids.shift

p (boarding_pass_ids - valid_ids).min + 1