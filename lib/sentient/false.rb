class Sentient::False
  def to_dimacs
    [[boolean.negate]]
  end

  def boolean
    @boolean ||= Sentient::Boolean.new
  end
end
