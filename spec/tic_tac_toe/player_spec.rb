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
      expect(&block).to raise_error(TicTacToe::Player::InvalidToken)
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
    TicTacToe::Player::VALID_TOKENS.each do |token|
      it "returns true when token is #{token}" do
        block = proc { described_class.validate_token(token) }
        expect(&block).not_to raise_error
      end
    end

    it "raises an error with invalid token" do
      block = proc { described_class.validate_token("L") }
      expect(&block).to raise_error(TicTacToe::Player::InvalidToken)
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
      expect(&block).to raise_error(TicTacToe::Player::InvalidToken)
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
    xit "gets a location from the user"
    xit "delegates adding the mark to the board"

    context "when the user input causes a board error" do
      xit "outputs the error message"
      xit "calls place_mark, to let the user fix their bad input"
    end
  end

  describe "#won?" do
    xit "returns true for all three in a row conditions"
    xit "returns false for non three in a row conditions"
  end

  describe "#_ask_user_for_move" do
    xit "addresses the player by name, to get user input"
  end

  describe "#_check_three" do
    xit "returns true when the three tiles given match the user's token"
    xit "returns false when any of the three tiles given don't match the user's token"
  end

  describe "#_check_left_diagonal" do
    xit "returns true when the board's diagonal, top left to bottom right, match the user's token"
    xit "returns false when the board's diagonal, top left to bottom right, does not match the user's token"
  end

  describe "#_check_right_diagonal" do
    xit "returns true when the board's diagonal, top right to bottom left, match the user's token"
    xit "returns false when the board's diagonal, top right to bottom left, does not match the user's token"
  end
end
