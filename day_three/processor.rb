require 'pry'
file = File.open('input.txt')
input = file.read

class Rucksack
  LETTERS = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

  attr_reader :prize, :compartment_left, :compartment_right

  def initialize(line)
    items = line.split(//)
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

  def priorities
    @priorities ||= begin
                      intermediate_hash = {}
                      LETTERS.each_with_index { |letter, index| intermediate_hash[letter] = index + 1 }
                      intermediate_hash
                    end
  end
end

rucksacks = input.split(/\n/).map { |line| Rucksack.new(line) }
puts rucksacks.sum { |rucksack| rucksack.prize }
