require_relative '../board'
require 'rspec'
RSpec.describe Board do
  let(:board_string) do
    "105802000090076405200400819019007306062083000000061050007600030430020501600308900"
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
      expect(@board.board[8][4].layers[0]).to eq(false)
    end
  end

  describe "#update!" do
    before { p @board }
    before { @board.update! }
    before { p @board }
    it "sets a value if the row has only one nil" do
      expect(@board.board.first.last.value).to eq(3)
      expect(@board.board[0][4].value).to eq(9)
    end
    it "sets a value if the column has only one nil" do
      expect(@board.board[6][0].value).to eq(9)
    end
    it "sets a value if the box has only one nil" do
      expect(@board.board[1][0].value).to eq(8)
    end
  end
end
