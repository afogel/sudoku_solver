require_relative 'cell'
class Board
  attr_reader :board
  def initialize(board_string)
    @board = []
    make_board
    load_hints(board_string)
  end


  # return an array of possible number
  def get_possibilities(row, col)
    possibilities = get_row_values(row) + get_col_values(col) + get_box_values(row,col)
    (1..9).to_a - possibilities.uniq
  end

  # update the value in that cell, then for every cell in that row, column,
  # and box we will update the possibilities for those cells
  def update_value(row, col, answer)
    @board[row][col].value = answer
    update_layer(row, col, answer)
  end

  def update_layer(row, col, answer)
    update_cell = proc {|cell| cell.eliminate_possibility(answer)}
    get_row_cells(row).each(&update_cell)
    get_col_cells(col).each(&update_cell)
    get_box_cells(row,col).each(&update_cell)
  end


  # after each iteration, call Cell#update! for all cells
  def update!
    update_segment("row")
    update_segment("col")
    update_boxes
  end


  # print board string
  def to_s
    board_string = @board.flatten.map(&:value).map{ |el| el.nil? ? 0 : el }
    print_string = ("-"*27)+"\n"
    board_string.each_slice(3).with_index do |box_chunk, idx|
      print_string += " | #{box_chunk.join(' ')}"
      print_string += " |\n" if (idx+1) % 3 == 0 && !idx.zero?
      print_string += ("-"*27)+"\n" if (idx+1) % 9 == 0
    end
    print_string
  end

  private
  def make_board
    9.times do |i|
      @board[i] = Array.new(9, nil)
      @board[i].map! {|el| el = Cell.new}
    end
  end

  # load hints takes in a string and fills in the correct values in our
  # internal board model
  def load_hints(board_string)
    board_string.each_char.with_index do |char, idx|
      update_value(row_index(idx),col_index(idx), char.to_i) unless char.to_i.zero?
    end
  end

  def update_boxes
    (0..8).step(3) do |row_index|
      (0..8).step(3) do |col_index|
        values_replaced = 1
        while values_replaced > 0
          values_replaced = 0
          unsolved_values = ( 1..9).to_a - get_box_values(row_index, col_index)
          unsolved_values.each do |unsolved_value|
            layer = get_layer(get_box_cells(row_index, col_index), unsolved_value)
            if layer.count(nil) == 1
              layer_index = layer.index(nil)
              cell_row_index = row_index + (layer_index / 3)
              cell_col_index = col_index + (layer_index % 3)
              values_replaced += 1
              update_value(cell_row_index, cell_col_index, unsolved_value)
            end
          end
        end
      end
    end
  end

  def update_segment(segment)
    9.times do |segment_idx|
      values_replaced = 1
      while values_replaced > 0
        values_replaced = 0
        unsolved_values = (1..9).to_a - send("get_#{segment}_values".to_sym, segment_idx)
        unsolved_values.each do |unsolved_value|
          layer = get_layer(send("get_#{segment}_cells".to_sym,segment_idx), unsolved_value)
          if layer.count(nil) == 1
            values_replaced += 1
            case segment
            when "row" then update_value(segment_idx,layer.index(nil),unsolved_value)
            when "col" then update_value(layer.index(nil), segment_idx, unsolved_value)
            end
          end
        end
      end
    end
  end

  def get_layer(cells, value)
    cells.map { |cell| cell.layers[value-1] }
  end


  def row_index(char_index)
    char_index / 9
  end

  def col_index(char_index)
    char_index % 9
  end

#
  def get_row_cells(row_coord)
    @board[row_coord]
  end

  def get_col_cells(col_coord)
    @board.map { |row| row[col_coord] }
  end

  def get_box_cells(row_coord, col_coord)
    top_left_row, top_left_col = get_top_left_cell(row_coord, col_coord)
    box_values = []
    3.times do |i|
      3.times do |j|
        box_values << @board[top_left_row+i][top_left_col+j]
      end
    end
    box_values
  end

  # calculate the top left coordinates for a box
  def get_top_left_cell(row_coord, col_coord)
    [(row_coord/3)*3,(col_coord/3)*3]
  end

# Methods to map values to blocks of cells
  # given the coordinates of a cell, get all cells in that row
  def get_row_values(row_coord)
    get_row_cells(row_coord).map(&:value)
  end

  # given the coordinates of a cell, get all cells in that column
  def get_col_values(col_coord)
    get_col_cells(col_coord).map(&:value)
  end

  # given the coordinates of a cell, get all cells in that box
  def get_box_values(row_coord, col_coord)
    get_box_cells(row_coord,col_coord).map(&:value)
  end

end