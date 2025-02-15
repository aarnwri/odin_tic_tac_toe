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

    def ask_user_for_move
      print "Player #{@name}, what is your move? "
      gets.chomp
    end

    def place_mark(board, location)
      board.add_mark(@token, location)
    end
  end
end
