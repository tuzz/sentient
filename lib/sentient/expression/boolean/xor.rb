module Sentient
  module Expression
    class Boolean
      class Xor
        def initialize(left, right)
          self.left = left
          self.right = right
        end

        def to_dimacs
          left.to_dimacs + right.to_dimacs + [
            [left.boolean.negate, right.boolean.negate, boolean.negate],
            [left.boolean, right.boolean, boolean.negate],
            [left.boolean, right.boolean.negate, boolean],
            [left.boolean.negate, right.boolean, boolean],
          ]
        end

        def boolean
          @boolean ||= Boolean.new
        end

        private

        attr_accessor :left, :right
      end
    end
  end
end
