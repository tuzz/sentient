module Sentient
  module Expression
    class Boolean
      class If
        def initialize(condition, if_true, if_false)
          self.condition = condition
          self.if_true = if_true
          self.if_false = if_false
        end

        def to_dimacs
          expression.to_dimacs
        end

        def boolean
          expression.boolean
        end

        private

        def expression
          @expression ||= (
            Or.new(
              And.new(
                condition,
                if_true
              ),
              And.new(
                Not.new(condition),
                if_false
              )
            )
          )
        end

        attr_accessor :condition, :if_true, :if_false
      end
    end
  end
end
