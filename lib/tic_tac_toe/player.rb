module TicTacToe
  # Represents the player object
  class Player
    # Constructor for creating players... In this case we're getting
    # user input from the console.
    def self.create(num = 1)
      puts "Welcome to Tic Tac Toe, player #{num}."
      print "What do you call yourself? "
      name = gets.chomp
      Player.new(name)
    end

    def initialize(name)
      @name = name
    end
  end
end
