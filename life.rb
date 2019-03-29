require 'json'
require 'numo/narray'
require_relative 'config/environment.rb'

class Life
  def self.call
    z = Numo::Int32.new(50,50).rand(2)
    10000.times do
      iterate(z)

      LiteCable.broadcast ::Game::Channel::NAME, message: cartesian(z)
      print '.'

      sleep 1
    end
  end

  def self.iterate(z)
    # Count neighbours
    n = z[0..-3,0..-3] + z[0..-3,1..-2] + z[0..-3,2..-1] +
        z[1..-2,0..-3]                  + z[1..-2,2..-1] +
        z[2..-1,0..-3] + z[2..-1,1..-2] + z[2..-1,2..-1]

    # Apply rules
    birth = n.eq(3) & z[1..-2,1..-2].eq(0)
    survive = (n.eq(2) | n.eq(3)) & z[1..-2,1..-2].eq(1)
    z[] = 0
    #z[1..-2,1..-2][birth | survive] = 1
    y = z[0..-3,0..-3].copy
    y[birth | survive] = 1
    z[1..-2,1..-2] = y
  end

  def self.cartesian(narray)
    result = []

    narray.each_with_index do |value, *coords|
      next if value.zero?

      result.push(
        x: coords.first,
        y: coords.last,
        value: value
      )
    end

    JSON.dump(result)
  end
end

Life.call
