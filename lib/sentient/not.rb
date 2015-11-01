class Sentient::Not
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
    @boolean ||= Sentient::Boolean.new
  end

  private

  attr_accessor :expression
end
