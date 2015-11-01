module Sentient
  module Expression
    class Program
      def initialize(expression)
        self.expression = expression
      end

      def to_dimacs
        expression.to_dimacs + [
          [expression.boolean]
        ]
      end

      private

      attr_accessor :expression
    end
  end
end
