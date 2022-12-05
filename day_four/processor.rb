require 'pry'

file = File.open('input.txt')
input = file.read

class Duty
  attr_reader :worker_one, :worker_two

  def initialize(pair)
    @worker_one = parse(pair.split(',').first)
    @worker_two = parse(pair.split(',').last)
  end

  def parse(range)
    numbers = range.scan(/\d+/)
    return (numbers[0].to_i..numbers[1].to_i)
  end

  def cover?
    worker_one.cover?(worker_two) || worker_two.cover?(worker_one)
  end
end

duties = input.split(/\n/).map do |line|
  Duty.new(line)
end

puts duties.select(&:cover?).count
