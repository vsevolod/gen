require 'json'
require 'matrix'
require 'numo/narray'

require_relative 'config/environment.rb'
require_relative 'mites/info'
require_relative 'mite'
require_relative 'food'
require_relative 'population'
require_relative 'land'

class Life
  attr_reader :land, :population, :foods

  def initialize(row_count: 100, column_count: 100)
    @land = Land.new(row_count, column_count)
    @population = Population.new(land: land, amount: 20)
    @foods = Array.new(20)
  end

  def call
    10000.times do
      check_food
      population.each(&:next_tik)
      LiteCable.broadcast(::Game::Channel::NAME, message: cartesian)

      sleep 0.2
      print '.'
    end
  end

  def check_food
    foods.map! do |food|
      if food
        next food if land[food.x, food.y] == food
        food.seed_to(land, *land.rand_field)
      else
        Food.new.tap do |f|
          f.seed_to(land, *land.rand_field)
        end
      end
    end
  end

  def cartesian
    JSON.dump(
      population: population.map(&:to_h),
      foods: foods.map(&:to_h)
    )
  end
end

Life.new.call
