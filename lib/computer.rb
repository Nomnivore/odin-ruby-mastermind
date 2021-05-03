# frozen_string_literal: false

# AI for the Code Maker mode
class Computer
  attr_reader :last_guess, :last_clue

  def initialize(game)
    @game = game
    @digits = %w[1 2 3 4 5 6]
    @counts = {} # "3" => 1 etc
    @last_guess = [] # %w[1 2 3 1]
    @next_digit = nil
    @last_clue = {} # 'X' => 2, 'O' => 2
  end

  def make_guess
    guess = []
    # prepend guess with what has worked so far
    @counts.each do |dig, num|
      num.times { guess.push(dig) }
    end
    return @last_guess = shuffled_guess(guess) if @counts.values.sum == 4

    # still looking for remaining digits
    # choose next digit, randomly, to try
    @next_digit = @digits.delete(@digits.sample)
    (4 - guess.length).times { guess.push(@next_digit) }
    @last_guess = guess.join
  end

  private

  def shuffled_guess(guess)
    loop do
      shff = guess.shuffle
      return shff.join unless @game.guesses.key?(shff.join)
    end
  end

  public

  def process_clue(clue)
    clue = clue_hash(clue)
    diff = clue_diff(@last_clue, clue)
    @last_clue = clue
    return if @counts.values.sum >= 4

    @counts[@next_digit] = diff.values.sum unless diff.values.sum.zero?
  end

  private

  def clue_hash(clue)
    counts = {}
    clue.split('').uniq.each do |let|
      counts[let] = clue.count(let)
    end
    counts
  end

  def clue_diff(last, clue)
    diff = {}
    clue.each { |let, ind| diff[let] = last.key?(let) ? ind - last[let] : ind }
    diff
  end
end
