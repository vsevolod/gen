require 'json'
require 'matrix'
require 'numo/narray'

require_relative 'config/environment.rb'
require_relative 'population'
require_relative 'land'

class Life
  attr_reader :land, :population

  def initialize(row_count: 100, column_count: 100)
    @land = Land.new(row_count, column_count)
    @population = Population.new(land: land, amount: 20)
  end

  def call
    LiteCable.broadcast ::Game::Channel::NAME, message: cartesian
  end

  def cartesian
    result = population.map do |info|
      {
        x: info.x,
        y: info.y,
        age: info.individ.age
      }
    end

    JSON.dump(result)
  end
end

Life.new.call
