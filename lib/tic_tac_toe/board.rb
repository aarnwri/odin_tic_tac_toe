module TicTacToe
  # Represents the board part of TicTacToe
  class Board
    def initialize
      @tiles = Array.new(3) { Array.new(3) { nil } }
    end
  end
end
