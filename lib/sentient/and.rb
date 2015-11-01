class Sentient::And
  def initialize(left, right)
    self.left = left
    self.right = right
  end

  def to_dimacs
    left.to_dimacs + right.to_dimacs + [
      [left.boolean.negate, right.boolean.negate, boolean],
      [left.boolean, boolean.negate],
      [right.boolean, boolean.negate],
    ]
  end

  def boolean
    @boolean ||= Sentient::Boolean.new
  end

  private

  attr_accessor :left, :right
end
