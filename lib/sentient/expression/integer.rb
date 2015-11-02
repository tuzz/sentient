module Sentient
  module Expression
    class Integer
      def initialize(precision = 1, booleans = nil)
        bits = precision + 1
        self.booleans = booleans || bits.times.map { Boolean.new }
        self.precision = precision
      end

      def to_s
        booleans.map(&:to_s).to_s
      end

      def ==(other)
        to_s == other.to_s
      end

      def set(bit, value)
        boolean = booleans[bit]
        array = booleans.dup

        unless boolean.positive? == value
          array[bit] = array[bit].negate
        end

        self.class.new(precision, array)
      end

      def negate
        array = toggle(booleans)

        position = position_of_first_zero(array)
        array = add_1(array, position)

        if precision_overflow?(position)
          array = increase_precision(array)
        end

        self.class.new(precision, array)
      end

      def to_dimacs
        booleans.map { |b| [b] }
      end

      def integer
        self
      end

      private

      def toggle(array)
        array.map(&:negate)
      end

      def position_of_first_zero(array)
        position = nil

        array.each.with_index do |boolean, index|
          unless boolean.positive?
            position = index
            break
          end
        end

        position
      end

      def add_1(array, position)
        if position
          (0..position).each do |i|
            array[i] = array[i].negate
          end
        else
          array = toggle(array)
        end

        array
      end

      def precision_overflow?(position)
        position == precision
      end

      def increase_precision(array)
        array + [Boolean.new.negate]
      end

      attr_accessor :booleans, :precision
    end
  end
end
