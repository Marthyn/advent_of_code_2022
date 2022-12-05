require 'pry'

file = File.open('input.txt')

input = file.read

elves = input.split(/^\s*$/)

elves.map { |x| x.split(/\n/).map(&:to_i).sum }.count

sum_per_elf = {}

elves.each_with_index do |elf, elf_number|
  amounts = elf.split(/\n/).map(&:to_i)
  sum_per_elf["elf_#{elf_number+1}"] = amounts.sum
end

most_amounts_on_top = sum_per_elf.sort_by { |key, value| value }.reverse

puts "Answer 1 🌟"
puts most_amounts_on_top.first
puts '----'

top_three_elves = most_amounts_on_top.take(3)

puts top_three_elves
puts '----'
puts "Answer 2 🌟🌟"
puts top_three_elves.sum { |elf, calories| calories }
puts '----'
