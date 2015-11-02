module Sentient
  module Solver
    class Lingeling
      def initialize(binary)
        self.binary = binary
      end

      def solve(header, dimacs)
        output = run(header, dimacs)
        parse(output)
      end

      private

      def run(header, dimacs)
        stdin, stdout, _ = Open3.popen3(binary)
        stdin.puts(header)

        dimacs.each do |line|
          presented_line = "#{line.join(" ")} 0"
          stdin.puts(presented_line)
        end

        stdin.close
        stdout.read
      end

      def parse(output)
        lines = output.split("\n")
        return Result.new([]) unless satisfiable?(lines)

        lines = lines.select { |l| l.start_with?("v") }

        array = lines.each.with_object([]) do |line, array|
          literals = line.split(" ")
          literals = literals.map(&:to_i)
          literals = literals.reject(&:zero?)

          array.concat(literals)
        end

        Result.new(array)
      end

      def satisfiable?(lines)
        line = lines.detect { |l| l.start_with?("s") }
        line.include?(" SATISFIABLE")
      end

      attr_accessor :binary
    end
  end
end
