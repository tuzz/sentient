require "spec_helper"

RSpec.describe Sentient::Expression::Boolean::If do
  let(:solver) { Sentient::Solver::Lingeling.new("lingeling") }
  let(:machine) { Sentient::Machine.new(solver) }

  it "evaluates the conditional as expected when run on the machine" do
    program = Sentient::Expression::Program.new(
      described_class.new(
        Sentient::Expression::Boolean::True.new,
        Sentient::Expression::Boolean::True.new,
        Sentient::Expression::Boolean::False.new
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable


    program = Sentient::Expression::Program.new(
      described_class.new(
        Sentient::Expression::Boolean::False.new,
        Sentient::Expression::Boolean::False.new,
        Sentient::Expression::Boolean::True.new
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
  end
end
