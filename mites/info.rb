module Mites
  class Info
    attr_reader :dna, :age

    def initialize(father_dna = nil, mother_dna = nil)
      @dna = Numo::Int32.new(50, 50).rand(2) if father_dna.nil?

      @age = 1
      # TODO: Add father x mother
      # TODO: Add small mutation
    end

    def grow_up(i)
      @age += i
    end
  end
end
