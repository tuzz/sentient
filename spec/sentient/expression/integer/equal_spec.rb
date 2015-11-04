require "spec_helper"

RSpec.describe Sentient::Expression::Integer::Equal do
  let(:solver) { Sentient::Solver::Lingeling.new("lingeling") }
  let(:machine) { Sentient::Machine.new(solver) }

  it "returns true if two integers are equal" do
    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(5),
        Sentient::Expression::Integer::Literal.new(5)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(-5),
        Sentient::Expression::Integer::Literal.new(-5)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(0),
        Sentient::Expression::Integer::Literal.new(0)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(
          1234567890123456789012345678901234567890123456789012345678901234567890
        ),
        Sentient::Expression::Integer::Literal.new(
          1234567890123456789012345678901234567890123456789012345678901234567890
        )
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
  end

  it "returns false if two integers are not equal" do
    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(4),
        Sentient::Expression::Integer::Literal.new(5)
      )
    )

    result = machine.run(program)
    expect(result).to_not be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(5),
        Sentient::Expression::Integer::Literal.new(-5)
      )
    )

    result = machine.run(program)
    expect(result).to_not be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(0),
        Sentient::Expression::Integer::Literal.new(1)
      )
    )

    result = machine.run(program)
    expect(result).to_not be_satisfiable


    program = Sentient::Expression::Program.new(
      expression = described_class.new(
        Sentient::Expression::Integer::Literal.new(1000000),
        Sentient::Expression::Integer::Literal.new(1000001)
      )
    )

    result = machine.run(program)
    expect(result).to_not be_satisfiable
  end
end
