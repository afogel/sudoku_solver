class Cell
  attr_reader :cell
  def initialize
    @cell = Array.new(9, nil)
  end

  def eliminate_possibility(value)
    @cell[value-1] = false
  end

  def value=(number)
    @cell.map!.with_index{|el,idx| idx == number-1}
  end

  # will return nil if no true elements in the cell array
  def value
    @cell.index(true)+1 if !@cell.include?(nil)
  end

  def update!
    @cell[@cell.index(nil)] = true if @cell.count(nil) == 1
  end
end