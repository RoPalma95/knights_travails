require 'pry'

class Board
  attr_accessor :board, :knight

  def initialize
    @board = Array.new(8) { Array.new(8, 0) }
    @knight = Knight.new
  end

  def print_board
    board.each do |row|
      p row
    end
  end

  def knight_moves(start, finish)
    knight.position = Position.new(start)
    possible_moves(knight.position, finish)
  end

  private

  # helper functions

  def possible_moves(start, finish)
    if start.square.any?(nil) 
      start.square = nil
      return
    end

    binding.pry

    temp = []

    # add 2 to row, add 1 to col

    temp << plus_minus_2(start.square.first, 'plus')  
    temp << plus_minus_1(start.square.last, 'plus')

    add_child(start, temp)

    # add 2 to row, subtract 1 from col

    temp.pop
    temp << plus_minus_1(start.square.last, 'minus')

    add_child(start, temp)

    # subtract 2 from row, subtract 1 to col

    temp.shift
    temp.unshift(plus_minus_2(start.square.first, 'minus'))

    add_child(start, temp)

    # subtract 2 from row, add 1 col

    temp.pop
    temp << plus_minus_1(start.square.last, 'plus')

    add_child(start, temp)

    # add 1 to row, add 2 to col

    temp[0] = plus_minus_1(start.square.first, 'plus')
    temp[-1] = plus_minus_2(start.square.last, 'plus')

    add_child(start, temp)

    # add 1 to row, subtract 2 from col

    temp.pop
    temp << plus_minus_2(start.square.last, 'minus')

    add_child(start, temp)

    # subtract 1 from row, subtract 2 from col

    temp.shift
    temp.unshift(plus_minus_1(start.square.first, 'minus'))

    add_child(start, temp)

    # subtract 1 from row, add 2 to col

    temp.pop
    temp << plus_minus_2(start.square.last, 'plus')

    add_child(start, temp) 

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

  def add_child(parent, array)
    parent.children << Position.new(array.dup)
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

  attr_accessor :square, :children, :id

  def initialize(square)
    @square = square
    @children = []
    @id = 0
  end
end


chess = Board.new
chess.knight_moves([4, 3], [0, 0])
binding.pry
chess.knight
