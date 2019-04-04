class Mite
  attr_accessor :x, :y
  attr_reader :info, :dna, :land

  def initialize(land)
    @info = Mites::Info.new
    @dna = Mites::DNA.new(input_dim: land.size)

    seed_to(land, *land.rand_field)
  end

  def seed_to(land, x, y)
    @x = x
    @y = y

    @land = land
    land[x, y] = self
  end

  def next_tik
    info.grow_up(1)
    relative_row = land.relative_row(x, y)
    land.move_to(self, dna.get_direction(relative_row))
  end

  def alive?
    info.age <= 100
  end

  def reseed_with(other_mite)
    dna.reseed_with!(other_mite.dna)

    info.age = 1
    info.foods = 0

    land[x, y] = nil
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
