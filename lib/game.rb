# frozen_string_literal: false

require_relative './display'
require 'colorize'

# The main logic/flow of the game
class Game
  attr_reader :turns

  include Display

  def initialize
    @mode = nil
    @code = nil
    @turns = 12
    @colors = %w[R G B Y P C]
  end

  def play
    system 'clear'
    pick_gamemode
    case @mode
    when :breaker
      # breaker mode, computer makes code and player guesses
      codebreaker_rules
      make_code
      player_guesses

    end
  end

  def pick_gamemode
    puts "Please choose the gamemode you'd like to play:\n[1] Codebreaker\n[2] Codemaker (WIP)"
    choice = gets.chomp.to_i
    until choice.eql?(1) || choice.eql?(2)
      puts "Type '1' or '2' (without quotes) corresponding to your choice"
      choice = gets.chomp.to_i
    end
    @mode = %i[breaker maker][choice - 1]
  end

  def make_code
    @code = []
    4.times { @code.append(@colors.sample) }
  end

  

  def player_guesses
    color_options
    # etc
  end

end
