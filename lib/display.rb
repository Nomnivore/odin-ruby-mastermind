# frozen_string_literal: false

# functions for printing to the CLI
module Display
  def codebreaker_rules # rubocop:disable Metrics/MethodLength
    system 'clear'
    puts 'The computer has generated a randomized 4 digit code. '
    puts "You will have #{@turns} attempts to guess the correct code in exact order."
    puts 'The possible digits are as follows:'
    color_options
    puts "\nYour guess should consist of 4 numbers,"
    puts 'in the order of your guess. No blanks will be allowed.'
    puts 'Ex: 1241'
    puts "After each guess, you'll receive a clue of up to 4 letters, in no particular order:"
    puts 'O: A digit is correct, but in the wrong place'
    puts 'X: A digit is correct and in the right place.'
    puts "\nPress Enter when you are ready to start guessing!"
    gets
    system 'clear'
  end

  def guess_header
    system 'clear'
    puts "Guess ##{@guesses.length + 1}/12"
    puts 'Previous guesses:' unless @guesses.length.zero?
    @guesses.each do |guess, resp|
      puts "  #{guess} -> [ #{resp} ]"
    end
    puts "\n"
    color_options
    puts "DEBUG!: Code: #{@code.join}"
  end

  def color_options
    puts '[ 1 ] [ 2 ] [ 3 ] [ 4 ] [ 5 ] [ 6 ]'
  end
end
