# frozen_string_literal: true

require_relative "player/errors"

module TicTacToe
  # Represents the player object
  class Player
    TOKENS = %w[X O].freeze

    class << self
      # Constructor for creating players... In this case we're getting
      # user input from the console.
      def create(token)
        validate_token(token)

        puts "Welcome to Tic Tac Toe, player #{token}."
        print "What do you call yourself? "
        name = gets.chomp
        Player.new(name, token)
      end

      def validate_token(token)
        return if TOKENS.include?(token)

        raise InvalidTokenError.new(nil, token)
      end
    end

    def initialize(name, token)
      _validate_token(token)

      @name  = name
      @token = token
    end

    attr_reader :name, :token

    def place_mark(board)
      location = _ask_user_for_move
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
      board.three_in_a_row?(@token)
    end

    private

    def _validate_token(token)
      self.class.validate_token(token)
    end

    def _ask_user_for_move
      print "Player #{@name}, what is your move? "
      gets.chomp
    end
  end
end
