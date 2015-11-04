module Sentient
  module Expression
    class Boolean
      class False
        def to_dimacs
          [[boolean.negate]]
        end

        def boolean
          @@boolean ||= Boolean.new
        end
      end
    end
  end
end
