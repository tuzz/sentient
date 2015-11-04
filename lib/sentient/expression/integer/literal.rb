module Sentient
  module Expression
    class Integer
      class Literal
        def initialize(number)
          self.number = number
        end

        def to_dimacs
          if positive?
            booleans = positive_booleans
          else
            booleans = negative_booleans
          end

          booleans.map { |b| [b] }
        end

        def integer
          @integer ||= Integer.new(binary.size + 1)
        end

        private

        def positive_booleans
          booleans = integer.booleans.dup

          binary.each.with_index do |bit, index|
            booleans[index] = booleans[index].negate unless bit
          end

          booleans[-1] = booleans[-1].negate

          booleans
        end

        def negative_booleans
          booleans = positive_booleans.map(&:negate)
          position = position_of_first_zero(booleans)

          add_1(booleans, position)
        end

        def position_of_first_zero(booleans)
          position = nil

          booleans.each.with_index do |boolean, index|
            unless boolean.positive?
              position = index
              break
            end
          end

          position
        end

        def add_1(booleans, position)
          (0..position).each do |i|
            booleans[i] = booleans[i].negate
          end

          booleans
        end

        def binary
          n = positive? ? number : -number
          bits = n.to_s(2).chars
          bits = bits.map { |b| b == "1" }
          bits.reverse
        end

        def positive?
          number >= 0
        end

        attr_accessor :number
      end
    end
  end
end
