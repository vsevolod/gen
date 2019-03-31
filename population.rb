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

  private

  def culture(amount)
    Array.new(amount) do
      Mite.new.tap do |mite|
        mite.move_to(land, *land.rand_field)
      end
    end
  end
end
