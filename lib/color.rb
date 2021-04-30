class Color
  def initialize(name)
    @name = name.capitalize
    @id = name[0].upcase
  end

  def to_s
    @name
  end
end
