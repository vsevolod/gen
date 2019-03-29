require 'rubygems'
require 'securerandom'
require 'pp'

require 'numo/narray'

require './individ'

FIELD_SIZE = [1000, 1000]
GROUPS_SIZE = 10
DNA_DIM = [5, 5]

# Fill initial groups
initial_enum = Enumerator.new do |result|
  GROUPS_SIZE.times do
    initial_dna = Numo::DFloat.new(*DNA_DIM).rand
    individ = Individ.new(initial_dna)

    result << individ.position()
  end
end

groups = Numo::DFloat[*initial_enum]

p groups
