class Sentient::Equal
  def initialize(left, right)
    self.left = left
    self.right = right
  end

  def to_dimacs
    left.to_dimacs + right.to_dimacs + [
      [left.boolean, right.boolean, boolean],
      [left.boolean, right.boolean.negate, boolean.negate],
      [left.boolean.negate, right.boolean, boolean.negate],
      [left.boolean.negate, right.boolean.negate, boolean],
    ]
  end

  def boolean
    @boolean ||= Sentient::Boolean.new
  end

  private

  attr_accessor :left, :right
end
