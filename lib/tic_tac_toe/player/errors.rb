# frozen_string_literal: true

module TicTacToe
  class Player
    # Error raised when a new player is initialized with an invalid token
    class InvalidTokenError < StandardError
      def initialize(_msg, token)
        msg  = "Token (#{token}) is invalid. "
        msg += "It must be one of #{TicTacToe::Player::TOKENS.join(', ')}"
        super(msg)
      end
    end

    ERRORS = [
      InvalidTokenError
    ].freeze
  end
end
