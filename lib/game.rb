# frozen_string_literal: false

require_relative './display'
require_relative './computer'
require 'colorize'

# The main logic/flow of the game
class Game # rubocop:disable Metrics/ClassLength
  attr_reader :turns, :guesses

  include Display

  def initialize
    @mode = nil
    @code = nil
    @turns = 12
    @colors = %w[1 2 3 4 5 6]
    @guesses = {}
  end

  def play
    system 'clear'
    pick_gamemode
    case @mode
    when :breaker
      # breaker mode, computer makes code and player guesses
      play_breaker
    when :maker
      # maker mode, player makes code and computer guesses
      @ai = Computer.new(self)
      play_maker
    end
  end

  private

  def play_breaker
    codebreaker_rules
    make_code
    player_guesses
    breaker_end
  end

  def play_maker
    codemaker_rules
    player_code
    computer_guesses
    maker_end
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

  def player_code
    puts 'Enter your secret code:'
    @code = loop do
      print '> '
      code = gets.chomp.match(/[1-6]{4}/i).to_s.split('')
      break code unless code.empty?

      puts 'Invalid guess: Must be a four digit sequence consisting of 1-6'
    end
  end

  def player_guesses
    while @guesses.length < @turns
      guess_header
      guess = gets_guess
      process_guess(guess)
      break if correct?(guess)
    end
  end

  def computer_guesses
    while @guesses.length < @turns
      # ai will call process_guess func
      guess = @ai.make_guess
      x = process_guess(guess)
      @ai.process_clue(x)
      puts_ai_result
      break if correct?(guess)

      sleep(1)
    end
  end

  def gets_guess # rubocop:disable Metrics/MethodLength
    loop do
      print "##{@guesses.length + 1}: "
      guess = gets.chomp.match(/[1-6]{4}/i).to_s
      if guess.empty?
        puts 'Invalid guess: Must be 4 numbers in a row'
      elsif @guesses.key?(guess)
        puts 'You already guessed that!'
      else
        break guess
      end
    end
  end

  public

  def process_guess(guess) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    # i'm sure it's badly written code, but it does what it's supposed to. would love to know a more elegant solution!
    clue = []
    copy = @code.dup
    guess_copy = guess.split('')
    guess_copy.each_with_index do |color, ind|
      next unless copy[ind] == color

      clue.push('X')
      copy[ind] = nil
      guess_copy[ind] = nil
    end
    guess_copy.each do |color|
      next unless color

      if copy.include?(color)
        clue.push('O')
        copy[copy.index(color)] = nil
      end
    end
    @guesses[guess] = clue.sort.join
  end

  private

  def correct?(guess)
    @guesses[guess].eql?('XXXX')
  end

  def breaker_end
    msg = [
      'You got it! It was',
      'Game over! The correct code was'
    ][@guesses.value?('XXXX') ? 0 : 1]
    puts "#{msg} #{@code.join}"
  end

  def maker_end
    if @guesses.value?('XXXX')
      puts "Guessed it in #{@guesses.length} turns!"
    else
      puts 'You win! I could not guess your secret code.'
    end
  end
end
