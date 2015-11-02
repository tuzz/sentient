module Sentient
  module Expression
    class Integer
      class Literal
        def initialize(number)
          self.number = number
        end

        def to_dimacs
          negative = binary.each.with_index.reduce(integer) do |integer, (bit, index)|
            integer.set(index, bit)
          end
          positive = negative.set(precision, false)
          signed = positive? ? positive : positive.negate

          signed.to_dimacs
        end

        def integer
          @integer ||= Integer.new(precision)
        end

        private

        def precision
          binary.length
        end

        def binary
          n = positive? ? number : -number
          bits = n.to_s(2).chars
          bits = bits.map { |b| b == "1" }
          bits.reverse
        end

        def positive?
          number > 0
        end

        attr_accessor :number
      end
    end
  end
end
