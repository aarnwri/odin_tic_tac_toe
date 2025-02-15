module TicTacToe
  # Represents the board part of TicTacToe
  # "Current board state:"
  # "     1     2     3   "
  # "   -----|-----|-----"
  # "a |     |     |     |"
  # "   -----|-----|-----"
  # "b |     |     |     |"
  # "   -----|-----|-----"
  # "c |     |     |     |"
  # "   -----|-----|-----"
  # For ex. @tiles[0][2] should be a3
  class Board
    ROW_LABELS = %w[a b c].freeze

    def initialize
      @tiles = Array.new(3) { Array.new(3) { nil } }
    end

    def render
      _render_header
      _render_row_divider

      @tiles.each_with_index do |row, row_idx|
        # first we need the row label
        str = "\t#{ROW_LABELS[row_idx]} |"
        row.each_with_index do |col, _col_idx|
          str += "  #{col || ' '}  |"
        end
        puts str
        _render_row_divider
      end
    end

    private

    def _render_header
      puts ""
      puts "\tCurrent board state:"
      puts "\t     1     2     3   "
    end

    def _render_row_divider
      puts "\t   -----|-----|-----"
    end
  end
end
