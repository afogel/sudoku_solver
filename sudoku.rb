require_relative 'board'
require_relative 'cell'

class Sudoku
  def initialize
  end

  # iterate over the board, solving each cell, until Sudoku#solved? is true
  def solve!
  end

  private
  # given a row and column index, we check if Board#get_possibilities
  # has only one element, and if it does then we update the value in
  # the board
  def attempt_solution(row, col)
  end

  # if there are no nil values, the board is solved
  def solved?
  end
end

