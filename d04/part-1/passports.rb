passports = File.read('passports_list.txt').split("\n\n").map { |passport| passport.gsub("\n", ' ') }.uniq

fields = %w(byr iyr eyr hgt hcl ecl pid)

passports.reject! { |passport| fields.any? {|field| !passport.include?(field) } }

p passports.count


