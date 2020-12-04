require 'ostruct'

def valid_pid?(pid)
    !(/^[0-9]*$/ =~ pid).nil?
end

def valid_height?(height)
    if height.include?('cm')
        height = Integer(height.delete('cm')) rescue nil
        return false unless height.between?(150, 193)
    elsif height.include?('in')
        height = Integer(height.delete('in')) rescue nil
        return false unless height.between?(59, 76)
    else
        return false
    end

    true
end

def unvalid_passport?(passport)
    return true unless passport.byr.to_i.between?(1920, 2002)
    return true unless passport.iyr.to_i.between?(2010, 2020)
    return true unless passport.eyr.to_i.between?(2020, 2030)
    return true unless %w(amb blu brn gry grn hzl oth).any? { |color| color == passport.ecl }
    return true unless passport.pid.size == 9 && valid_pid?(passport.pid)
    return true unless passport.hcl.size == 7 && passport.hcl[0] == '#' && passport.hcl.delete("##{/^[a-f0-9]/}").empty?
    return true unless valid_height?(passport.hgt)
end

fields = %w(byr iyr eyr hgt hcl ecl pid)

passports = File.read('passports_list.txt').split("\n\n").map { |passport| passport.gsub("\n", ' ') }.uniq
passports.reject! { |passport| fields.any? {|field| !passport.include?(field) } }

valid_passports = passports.map do |passport|
    valid_passport = OpenStruct.new(
        'byr' => nil,
        'iyr' => nil,
        'eyr' => nil,
        'hgt' => nil,
        'hcl' => nil,
        'ecl' => nil,
        'pid' => nil,
        'cid' => nil
    )

    passport.split(/\s/).each do |field|
        key, value = field.split(':')
         valid_passport[key] = value
    end

    valid_passport
end

p valid_passports.reject! { |valid_passport| unvalid_passport?(valid_passport)}.count
