require 'pry'
require 'ostruct'

conveyor_belt = File.read('bags.txt').split("\n")

bags = []

def disassemble_item(item)
  master_bag, bags = item.split(" bags contain ")

  bags = bags.split(',').map { |bag| bag.gsub(/[0-9]|bags|bag|\./, '').strip }

  OpenStruct.new(:master_bag => master_bag, :bags => bags)
end

@bags = conveyor_belt.map { |bag| disassemble_item(bag) }
@valid_bags = @bags.select { |bag| bag.master_bag == 'shiny gold'}

def valid_bag_finder(searched_bag, main_bag)
  @valid_bags << main_bag.select { |bag| bag.bags.include?(searched_bag) }
end

loop do
  @bags.each do |bags|
    @valid_bags.uniq.flatten.each do |bag|
      valid_bag_finder(bag.master_bag, @bags)
    end

    p @valid_bags.flatten.uniq.count
  end
end