module Sentient
  module Expression
    class Integer
      class Add
        def initialize(left, right)
          self.left = left
          self.right = right
        end

        def to_dimacs
          @to_dimacs ||= (
            dimacs = left.to_dimacs
            dimacs += right.to_dimacs
            dimacs += expressions.map(&:to_dimacs).flatten(1)

            dimacs.uniq { |a| a.map(&:to_s) }
          )
        end

        def integer
          @integer ||= Integer.new(booleans)
        end

        private

        def booleans
          @booleans ||= expressions.map(&:boolean)
        end

        def expressions
          @expressions ||= (
            left, right = pad
            pairs = left.integer.booleans.zip(right.integer.booleans)

            carry = Boolean::False.new
            expressions = pairs.map do |a, b|
              c_in = carry

              sum = adder_sum(a, b, c_in)
              carry = adder_carry(a, b, c_in)

              sum
            end

            expressions + [carry]
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

        def adder_sum(a, b, c_in)
          Boolean::Xor.new(
            Boolean::Xor.new(
              a,
              b
            ),
            c_in
          )
        end

        def adder_carry(a, b, c_in)
          Boolean::Or.new(
            Boolean::And.new(
              a,
              b
            ),
            Boolean::And.new(
              c_in,
              Boolean::Xor.new(
                a,
                b
              )
            )
          )
        end

        attr_accessor :left, :right
      end
    end
  end
end
