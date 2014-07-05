require_relative 'cell'
class Board

  def initialize(board_string)
    @board = Array.new(9) { Array.new(9,Cell.new) }
    load_hints(board_string)
  end

  # load hints takes in a string and fills in the correct values in our
  # internal board model
  def load_hints(board_string)
  end

  # return an array of possible number
  def get_possibilities(row, col)
  end

  # update the value in that cell, then for every cell in that row, column,
  # and box we will update the possibilities for those cells
  def update_value(row, col, answer)
  end

  # after each iteration, call Cell#update! for all cells
  def update!
  end

  # print board string
  def to_s
  end

  private
  # given the coordinates of a cell, get all cells in that row
  def get_row(row, col)
  end

  # given the coordinates of a cell, get all cells in that column
  def get_column(row, col)
  end

  # given the coordinates of a cell, get all cells in that box
  def get_box(row, col)
    top_left_row, top_left_col = get_top_left_cell(row, col)
  end

  # calculate the top left coordinates for a box
  def get_top_left_cell(row, col)
  end

end