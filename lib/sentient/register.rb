module Sentient
  class Register
    class << self
      def reset
        self.register = {}
        self.next_number = 1
      end

      def fetch(key)
        unless register.key?(key)
          register[key] = next_number
          self.next_number += 1
        end

        register.fetch(key)
      end

      def count
        next_number - 1
      end

      private

      attr_accessor :register, :next_number
    end
  end
end

Sentient::Register.reset
