module Sentient
  class Machine
    def initialize(solver)
      self.solver = solver
    end

    def run(program)
      header = program.header
      dimacs = program.to_dimacs

      solver.solve(header, dimacs)
    end

    private

    attr_accessor :solver
  end
end
