require_relative '../cell'
require 'rspec'
RSpec.describe Cell do

  describe "#eliminate_possibility" do
    it "sets the value at that level to false" do
      array = [nil,nil,nil,false,nil,nil,nil,nil,nil]
      cell = Cell.new
      cell.eliminate_possibility(4)
      expect(cell.cell).to eq(array)
    end
  end

  describe "#value=" do
    it "sets the value at that level to true and all others to false" do
      array = [false,false,false,true,false,false,false,false,false]
      cell = Cell.new
      cell.value = 4
      expect(cell.cell).to eq(array)
    end
  end

  describe "#value" do
    before(:each) { @cell = Cell.new }
    it "retrieves the value that is true" do
      @cell.value = 4
      expect(@cell.value).to eq(4)
    end
    it "returns nil if there is no true value" do
      expect(@cell.value).to be_nil
    end
  end

  describe "#update!" do
    it "sets a level to true if all others are false" do
      cell = Cell.new
      8.times do |i|
        cell.eliminate_possibility(i+1)
      end
      expect(cell.value).to be_nil
      cell.update!
      expect(cell.value).to eq(9)
    end
  end
end