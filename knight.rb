# frozen_string_literal: true

require 'pry'

class Board
  attr_accessor :board, :knight, :visited

  POSSIBLE_X = [2, 2, -2, -2, 1, 1, -1, -1].freeze
  POSSIBLE_Y = [-1, 1, 1, -1, 2, -2, 2, -2].freeze

  def initialize
    @board = Array.new(8) { Array.new(8, 0) }
    @knight = Knight.new
    @visited = {}
  end

  # returns minimmum number of moves to arrive at dest from start
  def possible_moves(start, dest, queue = [])
    # enqueue first node
    queue << Position.new(start)

    # loop until queue is empty
    until queue.empty?

      # pop and process first node
      current = queue.shift

      x = current.square.first
      y = current.square.last

      # return distance if current position matches dest position
      return current if x == dest.first && y == dest.last

      # skip current node if it has already been visited
      next if visited.include?(current)

      # add current position to visited
      visited[current] = current
      move = []

      # check for all possible movements and enqueue each valid one
      8.times do |i|
        move << x + POSSIBLE_X[i]
        move << y + POSSIBLE_Y[i]

        queue << Position.new(move.dup, current, current.dist + 1) if check_movement(move)
        move.clear
      end
    end
  end

  def find_path(position)
    return if position.nil?

    find_path(position.parent)
    print "#{position.square} "
  end

  private

  # checks if current movement is a valid movement
  def check_movement(current)
    return false if current.first.negative? || current.last.negative? || current.first >= 8 || current.last >= 8

    true
  end
end

class Knight
  attr_accessor :position, :path

  def initialize
    @position = nil
    @path = nil
  end
end

class Position
  attr_accessor :square, :dist, :parent

  def initialize(square, parent = nil, dist = 0)
    @square = square
    @dist = dist
    @parent = parent
  end

  def ==(other)
    self.class == other and
      other.square == @square
  end

  alias eql? ==

  def hash
    @square.hash
  end
end

chess = Board.new
final = chess.possible_moves([7, 0], [0, 7])
puts "Moves needed to reach target position: #{final.dist}"
puts 'The path to follow is: '
puts chess.find_path(final)
