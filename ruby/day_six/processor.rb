require 'pry'
require '../../utils/colors'
file = File.open('input.txt')
input = file.read

class Array
  def uniq?
    self.uniq.size == self.size
  end
end

class Processor
  attr_reader :datastream

  def initialize(input)
    @datastream = input.chars
  end

  def first_unique_set_of(size)
    (0..datastream.size).find do |i|
      set_range = i..(i+(size - 1))
      position = i + size
      return position if @datastream[set_range].uniq?
    end
  end
end

puts Processor.new(input).first_unique_set_of(4)
puts Processor.new(input).first_unique_set_of(14)
