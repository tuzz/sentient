module Sentient
  class True
    def to_dimacs
      [[boolean]]
    end

    def boolean
      @boolean ||= Boolean.new
    end
  end
end
