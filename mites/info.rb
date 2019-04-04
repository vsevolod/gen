module Mites
  class Info
    attr_accessor :foods, :age

    def initialize
      @age = rand(1..99)
      @foods = 0
    end

    def grow_up(i)
      @age += i
      @age = 1 if age < 1
    end
  end
end
