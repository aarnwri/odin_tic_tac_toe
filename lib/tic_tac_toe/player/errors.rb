# frozen_string_literal: true

module TicTacToe
  class Player
    # Error raised when a new player is initialized with an invalid token
    class InvalidToken < StandardError
      def initialize(_msg, token, valid_tokens)
        msg  = "Token (#{token}) is invalid. "
        msg += "It must be one of #{valid_tokens.join(', ')}"
        super(msg)
      end
    end

    ERRORS = [
      InvalidToken
    ].freeze
  end
end
