require 'pry'

file = File.open('input.txt')
input = file.read

class Round
  OPPONENT_ROCK = 'A'.freeze
  OPPONENT_PAPER = 'B'.freeze
  OPPONENT_SCISSORS = 'C'.freeze

  ME_ROCK = 'X'.freeze
  ME_PAPER = 'Y'.freeze
  ME_SCISSORS = 'Z'.freeze

  WIN = 'win'.freeze
  DRAW = 'draw'.freeze
  LOSS = 'loss'.freeze

  SCORING = {
    ME_ROCK => 1,
    ME_PAPER => 2,
    ME_SCISSORS => 3,
    WIN => 6,
    DRAW => 3,
    LOSS => 0
  }.freeze

  attr_reader :opponent_move, :my_move

  def initialize(moves)
    @opponent_move = moves.split.first
    @my_move = moves.split.last
  end

  def result
    case opponent_move
    when OPPONENT_SCISSORS
      return WIN if my_move == ME_ROCK
      return DRAW if my_move == ME_SCISSORS
      return LOSS if my_move == ME_PAPER
    when OPPONENT_PAPER
      return WIN if my_move == ME_SCISSORS
      return DRAW if my_move == ME_PAPER
      return LOSS if my_move == ME_ROCK
    when OPPONENT_ROCK
      return WIN if my_move == ME_PAPER
      return DRAW if my_move == ME_ROCK
      return LOSS if my_move == ME_SCISSORS
    else
      raise 'invalid opponent move'
    end
  end

  def points
    SCORING[result] + SCORING[my_move]
  end
end

rounds = input.split(/\n/).map { |moves| Round.new(moves) }

puts rounds.sum { |round| round.points }
