class Mite
  attr_reader :info, :x, :y

  def initialize(options = {})
    @info = Mites::Info.new(options[:father_dna], options[:mother_dna])
  end

  def move_to(land, x, y)
    @x = x
    @y = y

    land[x, y] = self
  end

  def next_tik
    info.grow_up(1)
  end
end
