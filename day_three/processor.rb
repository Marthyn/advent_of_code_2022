require 'pry'
file = File.open('input.txt')
input = file.read

class Array
  def in_groups_of(number, fill_with = nil)
    if number.to_i <= 0
      raise ArgumentError,
            "Group size must be a positive integer, was #{number.inspect}"
    end

    if fill_with == false
      collection = self
    else
      # size % number gives how many extra we have;
      # subtracting from number gives how many to add;
      # modulo number ensures we don't add group of just fill.
      padding = (number - size % number) % number
      collection = dup.concat(Array.new(padding, fill_with))
    end

    if block_given?
      collection.each_slice(number) { |slice| yield(slice) }
    else
      collection.each_slice(number).to_a
    end
  end
end

module Utilities
  LETTERS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  def priorities
    @priorities ||= begin
                      intermediate_hash = {}
                      LETTERS.each_with_index { |letter, index| intermediate_hash[letter] = index + 1 }
                      intermediate_hash
                    end
  end
end

class Rucksack
  include Utilities

  attr_reader :prize, :compartment_left, :compartment_right, :items

  def initialize(line)
    items = line.split(//)
    @items = items
    items_length = items.length

    @compartment_left = items.slice(0, (items_length / 2))
    @compartment_right = items.slice((items_length / 2), items_length)
  end

  def common
    (compartment_left & compartment_right).first
  end

  def prize
    priorities[common]
  end
end

class Group
  include Utilities

  attr_reader :rucksacks

  def initialize(group)
    raise 'invalid group' unless group.length == 3

    @rucksacks = group
  end

  def common
    (rucksacks[0].items & rucksacks[1].items & rucksacks[2].items).first
  end

  def prize
    priorities[common]
  end
end

rucksacks = input.split(/\n/).map { |line| Rucksack.new(line) }

puts rucksacks.sum { |rucksack| rucksack.prize }

groups = rucksacks.in_groups_of(3).map do |group_of_rucksacks|
  Group.new(group_of_rucksacks)
end

puts groups.sum { |group| group.prize }
