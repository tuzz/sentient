module Sentient
  module Expression
    class Boolean
      class Identity
        def initialize(expression)
          self.expression = expression
        end

        def to_dimacs
          expression.to_dimacs + [
            [expression.boolean, boolean.negate],
            [expression.boolean.negate, boolean],
          ]
        end

        def boolean
          @boolean ||= Boolean.new
        end

        private

        attr_accessor :expression
      end
    end
  end
end
