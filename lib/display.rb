# frozen_string_literal: false

# functions for printing to the CLI
module Display
  def codebreaker_rules # rubocop:disable Metrics/MethodLength
    system 'clear'
    puts 'The computer has generated a randomized 4 color code. '
    puts "You will have #{@turns} attempts to guess the correct colors in exact order."
    puts 'The possible colors are as follows:'
    color_options
    puts "\nYour guess should consist of 4 letters, corresponding to a color above"
    puts 'in the order of your guess. No blanks will be allowed.'
    puts 'Ex: RBGR'
    puts "After each guess, you'll receive a 4 letter response, in random order:"
    puts 'W: A color is correct, but in the wrong place'
    puts 'C: A color is correct and in the right place.'
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
    puts "[R] Red    [G] Green  [B] Blue\n[Y] Yellow [P] Purple [C] Cyan"
  end
end
