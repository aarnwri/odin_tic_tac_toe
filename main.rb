#! /usr/bin/env ruby

require_relative './lib/tic_tac_toe'

puts "this is where we will start the game from... any options will go here"

person_1 = "bob"
person_2 = "bill"

game = TicTacToe::Game.new(person_1, person_2)
