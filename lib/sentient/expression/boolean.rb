module Sentient
  module Expression
    class Boolean
      def self.reset
        @@next_number = 0
      end

      def self.count
        @@next_number
      end

      def initialize(number = nil)
        self.number = number || next_number
      end

      def to_s
        number.to_s
      end

      def ==(other)
        to_s == other.to_s
      end

      def negate
        self.class.new(-number)
      end

      def to_dimacs
        []
      end

      def boolean
        self
      end

      private

      def next_number
        @@next_number += 1
      end

      attr_accessor :number
    end
  end
end

Sentient::Expression::Boolean.reset
