module Sentient
  module Expression
    class Boolean
      def initialize(positive = true, identifier = object_id)
        self.positive = positive
        self.identifier = identifier
        number
      end

      def to_s
        number.to_s
      end

      def ==(other)
        to_s == other.to_s
      end

      def negate
        self.class.new(!positive?, identifier)
      end

      def positive?
        positive
      end

      def to_dimacs
        []
      end

      def boolean
        self
      end

      def to_ruby(result)
        result.fetch(boolean)
      end

      private

      def number
        number = Register.fetch(identifier)
        positive? ? number : -number
      end

      attr_accessor :identifier, :positive
    end
  end
end
