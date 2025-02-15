class TicTacToe::Game
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2

    @started  = false
    @finished = false
  end
end
