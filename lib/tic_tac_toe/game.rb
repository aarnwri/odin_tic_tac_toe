module TicTacToe
class Game
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2

    @started  = false
    @finished = false
  end

  def play
    puts "now playing the game: #{@player_1.inspect}"
    puts "also: #{@player_2.inspect}"
  end
end # class Game
end # module TicTacToe
