require 'pry'

class Board
  attr_accessor :board, :pieces, :moves

  def initialize
    @board = Array.new(8) { Array.new(8, 0) }
    @knight = Knight.new
    @moves = nil
  end

  def print_board
    board.each do |row|
      p row
    end
  end

  def knight_moves(start, finish)
    start = Position.new(start)
  end

  private

  # helper functions

  def possible_moves(start)
    return if start.position.any?(nil)

    temp = []

    # add 2 to row, add 1 to col

    temp << plus_minus_2(start.position.first, 'plus')  
    temp << plus_minus_1(start.position.last, 'plus')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # add 2 to row, subtract 1 from col

    temp.pop
    temp << plus_minus_1(start.position.last, 'minus')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # subtract 2 from row, subtract 1 to col

    temp.shift
    temp.unshift(plus_minus_2(start.position.first, 'minus'))

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # subtract 2 from row, add 1 col

    temp.pop
    temp << plus_minus_1(start.position.last, 'plus')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # add 1 to row, add 2 to col

    temp.first = plus_minus_1(start.position.first, 'add')
    temp.last = plus_minus_2(start.position.last, 'add')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # add 1 to row, subtract 2 from col

    temp.pop
    temp << plus_minus_2(start.position.last, 'minus')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # subtract 1 from row, subtract 2 from col

    temp.shift
    temp.unshift(plus_minus_1(start.position.first, 'minus'))

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)

    # subtract 1 from row, add 2 to col

    temp.pop
    temp << plus_minus_2(start.position.last, 'plus')

    start.children << Position.new(temp.dup)
    possible_moves(start.children.last)
  end

  def plus_minus_1(row_col, operation)
    if operation == 'plus' && row_col < 7
      return row_col += 1
    elsif operation == 'minus' && row_col > 0
      return row_col -= 1
    else
      nil
    end
  end

  def plus_minus_2(row_col, operation)
    if operation == 'plus' && row_col < 6
      return row_col += 2
    elsif operation == 'minus' && row_col > 1
      return row_col -= 2
    else
      nil
    end
  end

end

class Knight
  attr_accessor :position
  attr_reader :name, :color

  def initialize
    @name = 'knight'
    @position = nil
  end
end

class Position

  attr_accessor :position, :children

  @@correlative = 0

  def initialize(position)
    @position = position
    @children = []
    @@correlative += 1
    @id = @@correlative
  end
end


chess = Board.new

