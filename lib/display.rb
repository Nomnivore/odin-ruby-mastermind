# frozen_string_literal: false

# functions for printing to the CLI
module Display
  def codebreaker_rules # rubocop:disable Metrics/MethodLength
    system 'clear'
    puts 'The computer has generated a randomized 4 color code. '
    puts 'You will have 12 attempts to guess the correct colors in exact order.'
    puts 'The possible colors are as follows:'
    puts "R: Red, G: Green, B: Blue\nY:Yellow, P: Purple, C: Cyan"
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

  def color_options
    puts "[R] Red    [G] Green  [B] Blue\n[Y] Yellow [P] Purple [C] Cyan"
  end
end
