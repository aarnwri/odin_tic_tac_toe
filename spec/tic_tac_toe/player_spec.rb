# frozen_string_literal: true

require_relative "../../lib/tic_tac_toe"

RSpec.describe TicTacToe::Player do
  describe "::create" do
    before do
      allow(described_class).to receive(:puts)
      allow(described_class).to receive(:print)
      allow(described_class).to receive(:gets).and_return("tester\n")
    end

    it "raises an error if the player token is not X, or O" do
      block = proc { described_class.validate_token("L") }
      expect(&block).to raise_error(TicTacToe::Player::InvalidTokenError)
    end

    it "gets the player's name from the user, and returns appropriate player" do
      token = "X"
      expected_player = described_class.new("tester", token)
      created_player  = described_class.create(token)

      expect(created_player.name).to eq(expected_player.name)
      expect(created_player.token).to eq(expected_player.token)
    end
  end

  describe "::validate_token" do
    TicTacToe::Player::TOKENS.each do |token|
      it "returns true when token is #{token}" do
        block = proc { described_class.validate_token(token) }
        expect(&block).not_to raise_error
      end
    end

    it "raises an error with invalid token" do
      block = proc { described_class.validate_token("L") }
      expect(&block).to raise_error(TicTacToe::Player::InvalidTokenError)
    end
  end

  describe "#initialize" do
    let(:player_name) { "tester" }
    let(:valid_token) { "X" }
    let(:invalid_token) { "L" }

    it "accepts name and token as arguments" do
      obj = described_class.new(player_name, valid_token)
      expect(obj.instance_variable_get("@name")).to eq(player_name)
      expect(obj.instance_variable_get("@token")).to eq(valid_token)
    end

    it "raises an error if the player token is not X, or O" do
      block = proc { described_class.new(player_name, "L") }
      expect(&block).to raise_error(TicTacToe::Player::InvalidTokenError)
    end
  end

  describe "#name" do
    it "returns the @name attr" do
      player = described_class.new("tester", "X")
      expect(player.name).to eq(player.instance_variable_get("@name"))
    end
  end

  describe "#token" do
    it "returns the @token attr" do
      player = described_class.new("tester", "X")
      expect(player.token).to eq(player.instance_variable_get("@token"))
    end
  end

  describe "#place_mark" do
    it "gets a location from the user" do
      player = described_class.new("tester", "X")
      board  = instance_double(TicTacToe::Board)
      allow(board).to receive(:add_mark)

      expect(player).to receive(:_ask_user_for_move)
      player.place_mark(board)
    end

    it "delegates adding the mark to the board" do
      player = described_class.new("tester", "X")
      board  = instance_double(TicTacToe::Board)
      allow(player).to receive(:_ask_user_for_move)

      expect(board).to receive(:add_mark)
      player.place_mark(board)
    end

    context "when the user input causes a board error" do
      before do
        @player = described_class.new("tester", "X")
        @board  = instance_double(TicTacToe::Board)
        allow(@player).to receive(:_ask_user_for_move).and_return("a4", "a3")
        allow(@board).to(
          receive(:add_mark)
          .with("X", "a4")
          .and_raise(TicTacToe::Board::ERRORS[0].new(nil, "a4"))
        )
        allow(@board).to receive(:add_mark).with("X", "a3")
      end

      it "outputs the error message" do
        expect(@player).to receive(:puts).with("Sorry, that move is invalid.")
        expect(@player).to receive(:puts)
        @player.place_mark(@board)
      end

      it "calls place_mark, to let the user fix their bad input" do
        expect(@player).to receive(:place_mark).with(@board)
        @player.place_mark(@board)
      end
    end
  end

  describe "#won?" do
    it "delegates checking for 3 in a row to the board" do
      token  = "X"
      player = described_class.new("tester", token)
      board  = instance_double(TicTacToe::Board)

      expect(board).to receive(:three_in_a_row?).with(token)
      player.won?(board)
    end
  end

  describe "#_ask_user_for_move" do
    it "addresses the player by name, to get user input" do
      name   = "tester"
      player = described_class.new(name, "X")
      allow(player).to receive(:gets).and_return("a3\n")

      expect(player).to receive(:print).once.with(/.*#{name}.*/)
      player.send(:_ask_user_for_move)
    end
  end
end
