# frozen_string_literal: true

require_relative "../../lib/tic_tac_toe"

RSpec.describe TicTacToe::Game do
  let(:player1) { double "p1" }
  let(:player2) { double "p2" }

  subject(:game) { TicTacToe::Game.new(player1, player2) }

  let(:board) { game.instance_variable_get("@board") }

  # In the intialize method, we inject the players as dependencies, but we
  # create the board, as I don't think it makes sense for the board to not
  # be an intrinsic part of the TicTacToe game
  describe "#initialize" do
    it "receives two player objects as arguments" do
      expect { game }.not_to raise_error
    end

    it "assigns @current_player to player1" do
      expect(game.instance_variable_get("@current_player")).to eq(player1)
    end

    it "creates a new board object for use in the game" do
      expect(board).to be_a(TicTacToe::Board)
    end
  end

  # There's nothing to test with this method, since it's a script method
  # I'd be stubbing every method here.
  describe "#play" do
  end

  # This is also a script method, designed to handle the first turn of the
  # game, since we don't need to update @current_player on the first turn
  describe "#_iterate_first_turn" do
    it "does not swap current player" do
      allow(game).to receive(:_render_board)
      allow(game).to receive(:_add_mark)

      expect(game).not_to receive(:_swap_current_player)
      game.send(:_iterate_first_turn)
    end
  end

  # This is also a script method, it runs every turn after the first turn
  describe "#_iterate_turn" do
    it "swaps the current player before iterating through the turn" do
      allow(game).to receive(:_render_board)
      allow(game).to receive(:_add_mark)

      expect(game).to receive(:_swap_current_player)
      game.send(:_iterate_turn)
    end
  end

  describe "#_swap_current_player" do
    context "when @current_player is player1" do
      # By default player1 is @current_player, as tested in initialize
      it "sets @current_player to player2" do
        current_player = game.instance_variable_get("@current_player")
        expect(current_player).to eq(player1)

        game.send(:_swap_current_player)
        current_player = game.instance_variable_get("@current_player")
        expect(current_player).to eq(player2)
      end
    end

    context "when @current_player is player2" do
      before { game.instance_variable_set("@current_player", player2) }

      it "sets @current_player to player1" do
        current_player = game.instance_variable_get("@current_player")
        expect(current_player).to eq(player2)

        game.send(:_swap_current_player)
        current_player = game.instance_variable_get("@current_player")
        expect(current_player).to eq(player1)
      end
    end
  end

  describe "#_render_board" do
    it "delegates board rendering to the board object" do
      expect(board).to receive(:render)
      game.send(:_render_board)
    end
  end

  describe "#_add_mark" do
    it "delegates adding marks to the board to the current_player object" do
      current_player = game.instance_variable_get("@current_player")
      expect(current_player).to receive(:place_mark).with(board)
      game.send(:_add_mark)
    end
  end

  describe "#_finished?" do
    context "when the current player has made a winning move" do
      it "returns true" do
        allow(player1).to receive(:won?).with(board).and_return(true)
        allow(board).to receive(:full?).and_return(false)

        result = game.send(:_finished?)
        expect(result).to eq(true)
      end
    end

    context "when the current player hasn't won, but the board is full" do
      it "returns true" do
        allow(player1).to receive(:won?).with(board).and_return(false)
        allow(board).to receive(:full?).and_return(true)

        result = game.send(:_finished?)
        expect(result).to eq(true)
      end
    end

    context "when no winning move has been made, and the board is not full" do
      it "returns false" do
        allow(player1).to receive(:won?).with(board).and_return(false)
        allow(board).to receive(:full?).and_return(false)

        result = game.send(:_finished?)
        expect(result).to eq(false)
      end
    end
  end

  describe "#_congratulate_players" do
    before { allow(game).to receive(:puts) }

    context "when the current player has won the game" do
      it "honors the player with the use of their name" do
        current_player = game.instance_variable_get("@current_player")
        allow(current_player).to receive(:won?).with(board).and_return(true)

        expect(current_player).to receive(:name)
        game.send(:_congratulate_players)
      end
    end

    context "when there is no winner" do
      it "honors no name" do
        current_player = game.instance_variable_get("@current_player")
        allow(current_player).to receive(:won?).with(board).and_return(false)

        expect(current_player).not_to receive(:name)
        game.send(:_congratulate_players)
      end
    end
  end
end
