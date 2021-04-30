# frozen_string_literal: false

# require_relative './color'
require_relative './options'

# The main logic/flow of the game
class Game
  attr_reader :turns

  include Options

  def initialize
    @mode = nil
    @code = nil
    @turns = max_turns
  end

  def play
    system 'clear'
    pick_gamemode
    case @mode
    when :breaker
      # breaker mode, computer makes code and player guesses

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
    6.times { @code.append(colors.sample) }
    p @code
  end
end
Game.new
