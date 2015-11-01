module Sentient
  class Not
    def initialize(expression)
      self.expression = expression
    end

    def to_dimacs
      expression.to_dimacs + [
        [expression.boolean.negate, boolean.negate],
        [expression.boolean, boolean]
      ]
    end

    def boolean
      @boolean ||= Boolean.new
    end

    private

    attr_accessor :expression
  end
end
