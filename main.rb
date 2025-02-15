#! /usr/bin/env ruby

require_relative "lib/tic_tac_toe"

player1 = TicTacToe::Player.create("X")
player2 = TicTacToe::Player.create("O")

game = TicTacToe::Game.new(player1, player2)
game.play
