module TicTacToe
class Game
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2

    @board    = Board.new
    @started  = false
    @finished = false
  end

  def play
    # NOTE: This is just to debug...
    puts "now playing the game: #{@player_1.inspect}"
    puts "also: #{@player_2.inspect}"
    puts "using board: #{@board.inspect}"
  end
end # class Game
end # module TicTacToe
