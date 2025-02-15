#! /usr/bin/env ruby

require_relative './lib/tic_tac_toe'

player_1 = TicTacToe::Player.create(1)
player_2 = TicTacToe::Player.create(2)

game = TicTacToe::Game.new(player_1, player_2)
game.play
