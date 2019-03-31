require 'json'
require 'matrix'
require 'numo/narray'

require_relative 'config/environment.rb'
require_relative 'mites/info'
require_relative 'mite'
require_relative 'population'
require_relative 'land'

class Life
  attr_reader :land, :population

  def initialize(row_count: 100, column_count: 100)
    @land = Land.new(row_count, column_count)
    @population = Population.new(land: land, amount: 20)
  end

  def call
    100.times do
      population.each(&:next_tik)
      LiteCable.broadcast(::Game::Channel::NAME, message: cartesian)

      sleep 0.5
      print '.'
    end
  end

  def cartesian
    result = population.map do |mite|
      {
        x: mite.x,
        y: mite.y,
        age: mite.info.age
      }
    end

    JSON.dump(result)
  end
end

Life.new.call
