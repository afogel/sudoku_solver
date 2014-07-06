require_relative '../board'
require 'rspec'
RSpec.describe Board do
  let(:board_string) do
    "105802000090076405200400819019007306762083090000061050007600030430020501600308900"
  end

  before(:each) { @board = Board.new(board_string) }

  describe "#initialize" do
    it "sets cells for non-zero values in the string" do
      expect(@board.board[0][0].value).to eq(1)
      expect(@board.board[8][8].value).to eq(nil)
    end
  end

  describe "#get_possibilities" do
    it "returns array containing possible values for cell" do
      expect(@board.get_possibilities(0,1)).to eq([4,7])
    end
  end
  describe "#update_value" do
    it "sets a cell with its correct value" do
      @board.update_value(8,2,1)
      expect(@board.board[8][2].value).to eq(1)
      expect(@board.board[8][4].cell[0]).to eq(false)
    end
  end
  describe "#update!" do
    it "sets all remaining cells with a single possible solution to true"
  end
end
