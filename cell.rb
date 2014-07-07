class Cell
  attr_reader :layers
  def initialize
    @layers = Array.new(9, nil)
  end

  def eliminate_possibility(value)
    @layers[value-1] = false if @layers.index(true).nil?
  end

  def value=(number)
    @layers.map!.with_index{|el,idx| idx == number-1}
  end

  # will return nil if no true elements in the cell array
  def value
    @layers.index(true)+1 if !@layers.include?(nil)
  end

  def update!
    @layers[@layers.index(nil)] = true if @layers.count(nil) == 1
  end
end