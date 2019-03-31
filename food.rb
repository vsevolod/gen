class Food
  attr_reader :lives, :x, :y

  def initialize
    @lives = 30
  end

  def seed_to(land, x, y)
    @x = x
    @y = y

    @land = land
    land[x, y] = self
  end

  def to_h
    {
      x: x,
      y: y
    }
  end
end
