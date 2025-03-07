# frozen_string_literal: true

require_relative "board/errors"

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

    attr_reader :tiles

    def render
      _render_header
      _render_row_divider

      @tiles.each_with_index do |row, row_idx|
        str = "\t#{ROW_LABELS[row_idx]} |"
        row.each_with_index do |col, _col_idx|
          str += "  #{col || ' '}  |"
        end
        puts str
        _render_row_divider
      end
    end

    def add_mark(mark, location)
      _validate_location(location)
      row_idx, col_idx = _parse_location(location)
      @tiles[row_idx][col_idx] = mark
    end

    def full?
      @tiles.flatten.none?(&:nil?)
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

    # Turns a user given location, i.e. "a3" into [row, col]
    # coordinates
    def _parse_location(location)
      row, col = location.chars
      row = ROW_LABELS.index(row)
      col = col.to_i - 1
      [row, col]
    end

    def _validate_location(location)
      _validate_location_format(location)
      _validate_location_on_board(location)
      _validate_location_empty(location)
    end

    def _validate_location_format(location)
      # Make sure given location is only 2 chars, ie a1
      raise LocationFormatError.new("", location) if location.length != 2
    end

    def _validate_location_on_board(location)
      row, col = location.chars
      raise BadRowError.new("", row) unless ROW_LABELS.include?(row)
      raise BadColError.new("", col) unless (1..3).include?(col.to_i)
    end

    def _validate_location_empty(location)
      row, col = _parse_location(location)
      raise NonEmptyTile.new("", location) unless @tiles[row][col].nil?
    end
  end
end
