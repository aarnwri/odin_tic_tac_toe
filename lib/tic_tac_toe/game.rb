module TicTacToe
  # Runs the game loop for TicTacToe
  class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2

      @board    = Board.new
      @started  = false
      @finished = false
    end

    def play
      # NOTE: This is just to debug...
      puts "now playing the game: #{@player1.inspect}"
      puts "also: #{@player2.inspect}"
      puts "using board: #{@board.inspect}"
      @board.render
    end
  end
end
