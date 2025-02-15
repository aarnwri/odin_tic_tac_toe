#! /usr/bin/env ruby

require_relative "lib/tic_tac_toe"

player1 = TicTacToe::Player.create(1)
player2 = TicTacToe::Player.create(2)

game = TicTacToe::Game.new(player1, player2)
game.play
