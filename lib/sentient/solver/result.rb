module Sentient
  module Solver
    class Result
      def initialize(array)
        self.hash = array.each_with_object({}) do |element, hash|
          if element > 0
            hash[element.to_s] = true
          else
            hash[(-element).to_s] = false
          end
        end
      end

      def satisfiable?
        hash.any?
      end

      def fetch(boolean)
        hash[boolean.to_s]
      end

      private

      attr_accessor :hash
    end
  end
end
