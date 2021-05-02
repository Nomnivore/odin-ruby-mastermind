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
    @guesses = {}
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
      game_end
    end
  end

  def pick_gamemode
    print "Please choose the gamemode you'd like to play:\n[1] Codebreaker\n[2] Codemaker (WIP)\n \n#: "
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
    while @guesses.length < @turns
      guess_header
      guess = gets_guess
      process_guess(guess)
      break if correct?(guess)

    end
  end

  def gets_guess # rubocop:disable Metrics/MethodLength
    loop do
      print "##{@guesses.length + 1}: "
      guess = gets.chomp.match(/[rgbypc]{4}/i).to_s.upcase
      if guess.empty?
        puts 'Invalid guess: Must be 4 letters in a row, corresponding to colors'
      elsif @guesses.key?(guess)
        puts 'You already guessed that!'
      else
        break guess
      end
    end
  end

  def process_guess(guess) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    # i'm sure it's badly written code, but it does what it's supposed to. would love to know a more elegant solution!
    resp = []
    copy = @code.dup
    guess_copy = guess.split('')
    guess_copy.each_with_index do |color, ind|
      next unless copy[ind] == color

      resp.push('C')
      copy[ind] = 'x'
      guess_copy[ind] = 'x'
    end
    guess_copy.each do |color|
      next if color == 'x'

      if copy.include?(color)
        resp.push('W')
        copy[copy.index(color)] = 'x'
      end
    end
    @guesses[guess] = resp.sort.join
  end

  def correct?(guess)
    @guesses[guess].eql?('CCCC')
  end

  def game_end
    msg = [
      'You got it! It was',
      'Game over! The correct code was'
    ][@guesses.value?('CCCC') ? 0 : 1]
    puts "#{msg} #{@code.join}"
  end
end
