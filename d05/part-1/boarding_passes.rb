highest_boarding_passes_id = 0
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

boarding_passes.each do |boarding_pass|
  boarding_pass_id = boarding_pass_id_finder(boarding_pass)
  highest_boarding_passes_id = boarding_pass_id if boarding_pass_id > highest_boarding_passes_id
end

p highest_boarding_passes_id