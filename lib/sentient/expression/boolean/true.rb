module Sentient
  module Expression
    class Boolean
      class True
        def to_dimacs
          [[boolean]]
        end

        def boolean
          @@boolean ||= Boolean.new
        end
      end
    end
  end
end
