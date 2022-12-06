require 'pry'
require '../../utils/colors'
file = File.open('input.txt')
input = file.read

class Processor
  attr_reader :datastream

  def initialize(input)
    @datastream = input.chars
  end

  def first_unique_set_of_four
    (0..datastream.size).find do |i|
      set = @datastream[i..i+13]
      if set.uniq.size == set.size
        return (i + 14)
      end
    end
  end
end

puts Processor.new(input).first_unique_set_of_four
