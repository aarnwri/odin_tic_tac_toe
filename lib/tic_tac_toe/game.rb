# frozen_string_literal: true

module TicTacToe
  # Runs the game loop for TicTacToe
  class Game
    def initialize(player1, player2)
      @player1 = @current_player = player1
      @player2                   = player2

      @board = Board.new
    end

    def play
      _iterate_first_turn
      _iterate_turn until _finished?
      _render_board
      _congratulate_players
    end

    private

    def _iterate_first_turn
      _render_board
      _add_mark
    end

    def _iterate_turn
      _swap_current_player
      _render_board
      _add_mark
    end

    def _swap_current_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def _render_board
      @board.render
    end

    def _add_mark
      @current_player.place_mark(@board)
    end

    def _finished?
      @current_player.won?(@board) || @board.full?
    end

    def _congratulate_players
      if @current_player.won?(@board)
        puts "Congrats! to #{@current_player.name}, you won!"
      else
        # Must have been a tie
        puts "Congrats! to both of you, it's a cat's game! (tie)"
      end
    end
  end
end
