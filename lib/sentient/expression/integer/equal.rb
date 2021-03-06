module Sentient
  module Expression
    class Integer
      class Equal
        def initialize(left, right)
          self.left = left
          self.right = right
        end

        def to_dimacs
          results.map(&:to_dimacs).flatten(1)
        end

        def boolean
          expression.boolean
        end

        private

        def expression
          results.last
        end

        def results
          @expression ||= (
            left, right = pad
            pairs = left.integer.booleans.zip(right.integer.booleans)

            expressions = pairs.map do |a, b|
              Boolean::Equal.new(a, b)
            end

            expression = expressions.reduce(Boolean::True.new) do |accumulator, expression|
              Boolean::And.new(accumulator, expression)
            end

            [left, right, expression]
          )
        end

        def pad
          l = left.integer.booleans.count
          r = right.integer.booleans.count

          if l < r
            [Pad.new(left, r), right]
          elsif r < l
            [left, Pad.new(right, l)]
          else
            [left, right]
          end
        end

        attr_accessor :left, :right
      end
    end
  end
end
