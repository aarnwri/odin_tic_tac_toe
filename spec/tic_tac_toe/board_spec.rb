# frozen_string_literal: true

require_relative "../../lib/tic_tac_toe"

RSpec.describe TicTacToe::Board do
  describe "::ROW_LABELS" do
    it "is a list of valid row markers" do
      expect(described_class::ROW_LABELS).to include("a", "b", "c")
    end
  end

  describe "#initialize" do
    it "sets @tiles attribute to an empty 3 x 3 grid" do
      board = described_class.new
      expect(board.instance_variable_get("@tiles")[2][2]).to eq(nil)
    end
  end

  describe "#tiles" do
    it "returns the contents of the @tiles attribute" do
      board = described_class.new
      expect(board.tiles[2][2]).to eq(board.instance_variable_get("@tiles")[2][2])
    end
  end

  describe "#render" do
    let(:board) { described_class.new }

    context "with an empty board" do
      it "outputs a correctly formatted board" do
        board = described_class.new
        expect(board).to receive(:puts).with("")
        expect(board).to receive(:puts).with("\tCurrent board state:")
        expect(board).to receive(:puts).with("\t     1     2     3  ")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\ta |     |     |     |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\tb |     |     |     |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\tc |     |     |     |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")

        board.render
      end
    end

    context "with a full board" do
      before do
        tiles = [%w[X X O], %w[O O X], %w[X O X]]
        board.instance_variable_set("@tiles", tiles)
      end

      it "outputs a correctly formatted board" do
        expect(board).to receive(:puts).with("")
        expect(board).to receive(:puts).with("\tCurrent board state:")
        expect(board).to receive(:puts).with("\t     1     2     3  ")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\ta |  X  |  X  |  O  |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\tb |  O  |  O  |  X  |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")
        expect(board).to receive(:puts).with("\tc |  X  |  O  |  X  |")
        expect(board).to receive(:puts).with("\t   -----|-----|-----")

        board.render
      end
    end
  end

  describe "#add_mark" do
    let(:board) { described_class.new }

    it "validates the given location format" do
      expect { board.add_mark("X", "a,3") }.to raise_error(described_class::LocationFormatError)
      expect { board.add_mark("X", "c") }.to raise_error(described_class::LocationFormatError)
    end

    it "validates that the given location is on the board" do
      expect { board.add_mark("X", "d2") }.to raise_error(described_class::BadRowError)
      expect { board.add_mark("X", "a4") }.to raise_error(described_class::BadColError)
    end

    it "validates that the given location is empty" do
      tiles = [%w[X X O], %w[O O X], %w[X O X]]
      board.instance_variable_set("@tiles", tiles)

      expect { board.add_mark("X", "a2") }.to raise_error(described_class::NonEmptyTileError)
    end

    it "sets @tiles appropriately" do
      board.add_mark("X", "a1")
      tiles = board.instance_variable_get("@tiles")
      expect(tiles[0][0]).to eq("X")
    end
  end

  describe "#full?" do
    let(:board) { described_class.new }

    context "when the board is full" do
      before do
        tiles = [%w[X X O], %w[O O X], %w[X O X]]
        board.instance_variable_set("@tiles", tiles)
      end

      it "returns true" do
        expect(board.full?).to eq(true)
      end
    end

    context "when the board is not full" do
      before do
        tiles = [%w[X X O], %w[O O X], ["X", "O", nil]]
        board.instance_variable_set("@tiles", tiles)
      end

      it "returns false" do
        expect(board.full?).to eq(false)
      end
    end
  end

  describe "#three_in_a_row?" do
    let(:board) { described_class.new }
    let(:token) { "X" }

    context "when part of a row" do
      it "returns true" do
        tiles = [[token, token, token], [nil, nil, nil], [nil, nil, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)

        tiles = [[nil, nil, nil], [token, token, token], [nil, nil, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)

        tiles = [[nil, nil, nil], [nil, nil, nil], [token, token, token]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)
      end
    end

    context "when part of a column" do
      it "returns true" do
        tiles = [[token, nil, nil], [token, nil, nil], [token, nil, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)

        tiles = [[nil, token, nil], [nil, token, nil], [nil, token, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)

        tiles = [[nil, nil, token], [nil, nil, token], [nil, nil, token]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)
      end
    end

    context "when part of a diagonal" do
      it "returns true" do
        tiles = [[token, nil, nil], [nil, token, nil], [nil, nil, token]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)

        tiles = [[nil, nil, token], [nil, token, nil], [token, nil, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(true)
      end
    end

    context "when there is none" do
      let(:op_token) { "O" }

      it "returns false" do
        tiles = [[token, token, nil], [nil, nil, nil], [nil, nil, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(false)

        tiles = [[nil, token, nil], [nil, nil, nil], [nil, token, nil]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(false)

        tiles = [[token, nil, nil], [nil, op_token, nil], [nil, nil, token]]
        board.instance_variable_set("@tiles", tiles)
        expect(board.three_in_a_row?(token)).to eq(false)
      end
    end
  end

  # Tested via render
  describe "#_render_header"
  describe "#_render_row_divider"

  describe "#_parse_location" do
    let(:board) { described_class.new }

    it "returns an array of coordinates, both integers" do
      expect(board.send(:_parse_location, "a3")).to eq([0, 2])
      expect(board.send(:_parse_location, "a1")).to eq([0, 0])
      expect(board.send(:_parse_location, "c3")).to eq([2, 2])
      expect(board.send(:_parse_location, "b2")).to eq([1, 1])
    end
  end

  # Tested via add_mark
  describe "#_validate_location"
  describe "#_validate_location_format"
  describe "#_validate_location_on_board"
  describe "#_validate_location_empty"
end
