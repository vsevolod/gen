module Mites
  class Info
    DNA_SIZE = 50 # Only even vals

    attr_accessor :foods
    attr_reader :dna, :age

    def initialize
      @dna = Numo::Int8.new(DNA_SIZE, DNA_SIZE).rand(2)

      @age = rand(1..99)
      @foods = 0
    end

    def reseed_with(other_dna)
      @age = 1
      @foods = 0

      h = DNA_SIZE / 2

      ranges = {
        top_left: [0..h/2, 0..h/2],
        top_right: [0..h/2, h/2..-1],
        bottom_left: [h/2..-1, 0..h/2],
        bottom_right: [h/2..-1, h/2..-1]
      }

      ranges.each do |_k, v|
        dna[*v] = other_dna[*v] if rand(2) == 0
      end
    end

    def grow_up(i)
      @age += i
      @age = 1 if age < 1
    end

    def get_direction
      [:top, :right, :bottom, :left].sample
    end
  end
end
