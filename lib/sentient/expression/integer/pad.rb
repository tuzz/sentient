module Sentient
  module Expression
    class Integer
      class Pad
        def initialize(expression, width)
          self.expression = expression
          self.width = width

          if (a = width) < (b = expression.integer.booleans.count)
            error = "Not enough bits to pad (#{a} < #{b})"
            raise ArgumentError, error
          end
        end

        def to_dimacs
          expression.to_dimacs + identities.map(&:to_dimacs).flatten(1)
        end

        def integer
          @integer ||= Integer.new(booleans)
        end

        private

        def booleans
          @booleans ||= (
            booleans = expression.integer.booleans.dup

            identities.each do |identity|
              booleans.insert(-2, identity.boolean)
            end

            booleans
          )
        end

        def identities
          @identities ||= (
            booleans = expression.integer.booleans.dup
            pad_width = width - booleans.count

            pad_width.times.map do
              identity = Boolean::Identity.new(booleans.last)
            end
          )
        end

        attr_accessor :expression, :width
      end
    end
  end
end
