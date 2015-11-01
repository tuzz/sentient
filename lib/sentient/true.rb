class Sentient::True
  def to_dimacs
    [[boolean]]
  end

  def boolean
    @boolean ||= Sentient::Boolean.new
  end
end
