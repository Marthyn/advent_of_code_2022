require 'pry'
file = File.open('input.txt')
input = file.read

class Stack
  attr_reader :crates

  def initialize(crates)
    @crates = crates.reverse
  end

  def insert(crate)
    crates.push(crate).flatten!
  end

  def take(amount)
    crates.pop(amount)
  end

  def pretty
    crates.reverse.map { |x| "[#{x}]"}
  end
end

class Crane
  attr_reader :stacks

  def initialize(stacks)
    @stacks = stacks
  end

  def process(moves)
    moves.each do |move|
      stacks[move.stack_to].insert(stacks[move.stack_from].take(move.amount))
    end
  end

  def tops
    @stacks.map { |stack| stack.crates.last }
  end

  def print
    stacks.each_with_index do |stack, index|
      puts stack.pretty
      puts index
    end
  end
end

class Move
  attr_reader :amount, :stack_from, :stack_to
  def initialize(string)
    numbers = string.scan(/\d+/)

    raise 'invalid move' unless numbers.length == 3

    @amount = numbers[0].to_i
    @stack_from = numbers[1].to_i - 1
    @stack_to = numbers[2].to_i - 1
  end
end

stacks = [
  Stack.new(%w(W L S)),
  Stack.new(%w(Q N T J)),
  Stack.new(%w(J F H C S)),
  Stack.new(%w(B G N W M R T)),
  Stack.new(%w(B Q H D S L R T)),
  Stack.new(%w(L R H F V B J M)),
  Stack.new(%w(M J N R W D)),
  Stack.new(%w(J D N H F T Z B)),
  Stack.new(%w(T F B N Q L H)),
]

crane = Crane.new(stacks)
moves = input.split(/\n/).map { |string| Move.new(string) }

crane.process(moves)
puts "--- RESULT ---"
puts crane.tops.join
