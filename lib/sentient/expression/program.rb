module Sentient
  module Expression
    class Program
      def initialize(expression)
        self.expression = expression
      end

      def to_dimacs
        @dimacs ||= expression.to_dimacs + [[expression.boolean]]
      end

      def header
        clause_count = to_dimacs.count
        literal_count = Boolean.count

        "p cnf #{literal_count} #{clause_count}\n"
      end

      attr_accessor :expression
    end
  end
end
