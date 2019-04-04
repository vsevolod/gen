# TODO: Enumerable class instead of array
class Population
  attr_reader :land, :array

  def initialize(land:, amount: 100)
    @land = land
    @array = culture(amount)
  end

  def each(&block)
    array.each(&block)
  end

  def map(&block)
    array.map(&block)
  end

  def top_mite(except: nil)
    max_foods = array.map do |mite|
      next -1 if except == mite

      mite.info.foods
    end.max

    array.select do |mite|
      next false if except == mite

      mite.info.foods == max_foods
    end.sample
  end

  private

  def culture(amount)
    Array.new(amount) do
      Mite.new(land)
    end
  end
end
