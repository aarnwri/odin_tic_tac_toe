module TicTacToe
  # Represents the player object
  class Player
    # Constructor for creating players... In this case we're getting
    # user input from the console.
    def self.create(token)
      puts "Welcome to Tic Tac Toe, player #{token}."
      print "What do you call yourself? "
      name = gets.chomp
      Player.new(name, token)
    end

    def initialize(name, token)
      @name  = name
      @token = token
    end

    attr_reader :name, :token

    def ask_user_for_move
      print "Player #{@name}, what is your move? "
      gets.chomp
    end

    def place_mark(board)
      location = ask_user_for_move
      begin
        board.add_mark(@token, location)
      rescue *Board::ERRORS => e
        puts "Sorry, that move is invalid."
        puts e.message
        place_mark(board)
      end
    end

    # Checks the board for 3 in a row of the player's token
    def won?(board)
      (0..2).each do |i|
        # Check row
        return true if _check_three(board.tiles[i])

        # Check column
        return true if _check_three(
          [board.tiles[0][i], board.tiles[1][i], board.tiles[2][i]]
        )
      end

      # Check diagonals
      return true if _check_left_diagonal(board)
      return true if _check_right_diagonal(board)

      false
    end

    private

    def _check_three(tiles)
      tiles.all? { |tile| tile == @token }
    end

    def _check_left_diagonal(board)
      return true if _check_three(
        [board.tiles[0][0], board.tiles[1][1], board.tiles[2][2]]
      )

      false
    end

    def _check_right_diagonal(board)
      return true if _check_three(
        [board.tiles[0][2], board.tiles[1][1], board.tiles[2][0]]
      )

      false
    end
  end
end
