# frozen_string_literal: false

require_relative './game'

def play
  loop do
    game = Game.new
    game.play
    puts "\nWould you like to play again? (y/n)"
    break unless gets.chomp.include?('y')
  end
end

play
