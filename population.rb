require_relative 'individ'

class Population
  Info = Struct.new(:individ, :x, :y)

  attr_reader :land, :array

  def initialize(land:, amount: 100)
    @land = land
    @array = culture(amount)
  end

  def map(&block)
    array.map(&block)
  end

  private

  def culture(amount)
    Array.new(amount) do
      place = land.rand_field
      land[*place] = individ = Individ.new

      Info.new(individ, *place)
    end
  end
end
