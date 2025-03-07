module TicTacToe
  class Board
    # Error raised when anticipating a given location won't be parsable
    class LocationFormatError < StandardError
      def initialize(_msg, location)
        msg  = "Location (#{location}) given, not correctly formatted. "
        msg += "It should be two chars, coordinates, i.e. a3"
        super(msg)
      end
    end

    # Error raised when row given is not on the board
    class BadRowError < StandardError
      def initialize(_msg, row)
        msg  = "Row (#{row}) given not on board. "
        msg += "It should be one of #{ROW_LABELS.join(', ')}"
        super(msg)
      end
    end

    # Error raised when row given is not on the board
    class BadColError < StandardError
      def initialize(_msg, col)
        msg  = "Column (#{col}) given not on board. "
        msg += "It should be one of #{[1, 2, 3].join(', ')}"
        super(msg)
      end
    end

    # Error raised when the tile on the board is already populated
    class NonEmptyTile < StandardError
      def initialize(_msg, location)
        msg = "Location (#{location}) is not empty. "
        super(msg)
      end
    end

    ERRORS = [
      LocationFormatError,
      BadRowError,
      BadColError,
      NonEmptyTile
    ].freeze
  end
end
