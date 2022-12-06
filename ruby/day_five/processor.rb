require 'pry'
require '../../utils/colors'
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

  def pretty_print
    crates.reverse.map { |crate| "[#{crate}]"}
  end
end

class Crane
  attr_reader :stacks

  def initialize(stacks)
    @stacks = stacks
    print_state(:initial)
  end

  def process(moves)
    moves.each do |move|
      stack_from = stacks[move.stack_from]
      stack_to   = stacks[move.stack_to]

      crates = stack_from.take(move.amount)
      stack_to.insert(crates)

      print_move(move)
    end
    print_state(:final)
  end

  def print_state(state)
    puts '-------------'
    puts "#{state.capitalize} state"
    puts '-------------'
    pretty_print
  end

  def print_move(move, animation_interval: 0.0)
    38.times do
      puts "\n"
    end
    pretty_print
    puts '-------------'
    puts move.source
    puts '-------------'

    sleep(animation_interval)
  end

  def tops
    @stacks.map { |stack| stack.crates.last }
  end

  def columns_count
    @columns_count ||= 0..(stacks.length - 1)
  end

  def pretty_print
    rows_count = 0..(stacks.map(&:crates).map(&:size).max)
    rows_count.to_a.reverse.each do |row|
      columns_count.each do |column|
        crates = stacks[column].crates
        crate = crates[row]
        crate ? print("[#{crate}]\t".ukrainian) : print("\t")
      end
      print "\n"
    end
    puts " #{(1..(columns_count.size)).to_a.join(" \t ")}".ukrainian
  end
end

class Move
  attr_reader :amount, :stack_from, :stack_to, :source
  def initialize(string)
    numbers = string.scan(/\d+/)

    raise 'invalid move' unless numbers.length == 3

    @source = string
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
result = crane.tops.join

puts result.public_send(result == 'MHQTLJRLB' ? :green : :red)
