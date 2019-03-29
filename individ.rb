class Individ
  attr_reader :dna

  def initialize(father_dna, mother_dna = nil)
    @dna = father_dna if mother_dna.nil?
    # TODO: Add father x mother
    # TODO: Add small mutation
  end

  def to_f
    dna.sum
  end
end
