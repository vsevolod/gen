class Mite
  attr_accessor :x, :y
  attr_reader :info, :land

  def initialize(options = {})
    @info = Mites::Info.new(options[:father_dna], options[:mother_dna])
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

  def to_h
    {
      x: x,
      y: y,
      age: info.age
    }
  end
end
