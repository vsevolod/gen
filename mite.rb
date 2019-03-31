class Mite
  attr_accessor :x, :y
  attr_reader :info, :land

  def initialize
    @info = Mites::Info.new
  end

  def seed_to(land, x, y)
    @x = x
    @y = y

    @land = land
    land[x, y] = self
  end

  def next_tik
    info.grow_up(1)
    land.move_to(self, info.get_direction)
  end

  def alive?
    info.age <= 100
  end

  def reseed_with(other_mite)
    land[x, y] = nil
    info.reseed_with(other_mite.info.dna)

    seed_to(land, *land.rand_field)
  end

  def to_h
    {
      x: x,
      y: y,
      age: info.age
    }
  end
end
