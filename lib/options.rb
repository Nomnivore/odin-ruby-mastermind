require_relative './color'

# Configurable settings for the Mastermind game
module Options

  def max_turns
    12
  end

  def colors
    %w[Red Green Blue Yellow Purple].map { |x| Color.new(x) }
  end
end
