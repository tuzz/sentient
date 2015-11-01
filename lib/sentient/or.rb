module Sentient
  class Or
    def initialize(left, right)
      self.left = left
      self.right = right
    end

    def to_dimacs
      left.to_dimacs + right.to_dimacs + [
        [left.boolean, right.boolean, boolean.negate],
        [left.boolean.negate, boolean],
        [right.boolean.negate, boolean],
      ]
    end

    def boolean
      @boolean ||= Boolean.new
    end

    private

    attr_accessor :left, :right
  end
end
