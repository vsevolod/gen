module Mites
  class DNA
    DIRECTIONS = [:left, :right, :top, :bottom].freeze

    ALPHA = 0.1
    HIDDEN_DIM = 16
    OUTPUT_DIM = 1

    attr_reader :synapse_0, :synapse_1, :synapse_h, :input_dim

    def initialize(input_dim:)
      @input_dim = input_dim

      @synapse_0 = 2*Numo::DFloat.new(input_dim,HIDDEN_DIM).rand - 1
      @synapse_h = 2*Numo::DFloat.new(HIDDEN_DIM,HIDDEN_DIM).rand - 1
      @synapse_1 = 2*Numo::DFloat.new(HIDDEN_DIM,OUTPUT_DIM).rand - 1
    end

    def reseed_with!(other_dna)
      other_synapse_h = other_dna.synapse_h

      HIDDEN_DIM.times do |i|
        next if rand(2) == 0

        synapse_h[i, 0..-1] = other_synapse_h[i, 0..-1]

        next if rand(2) == 0

        synapse_h[i, 0..-1] *= 1 - ALPHA
      end
    end

    def get_direction(input)
      x_input = Numo::NArray[input]

      layer_0 = x_input.dot(synapse_0)
      layers_h = layer_0.dot(synapse_h)
      layer_1 = layers_h.dot(synapse_1)

      DIRECTIONS[layer_1.to_i % 4]
    end
  end
end
