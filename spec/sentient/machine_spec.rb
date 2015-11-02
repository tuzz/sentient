require "spec_helper"

RSpec.describe Sentient::Machine do
  let(:solver) { Sentient::Solver::Lingeling.new("lingeling") }
  subject { described_class.new(solver) }

  specify do
    a = Sentient::Expression::Boolean.new
    b = Sentient::Expression::Boolean.new
    c = Sentient::Expression::Boolean.new

    # true && (a || !b) && (c || false == a)
    program = Sentient::Expression::Program.new(
      Sentient::Expression::Boolean::And.new(
        Sentient::Expression::Boolean::True.new,
        Sentient::Expression::Boolean::And.new(
          Sentient::Expression::Boolean::Or.new(
            a,
            Sentient::Expression::Boolean::Not.new(
              b
            )
          ),
          Sentient::Expression::Boolean::Or.new(
            c,
            Sentient::Expression::Boolean::Equal.new(
              Sentient::Expression::Boolean::False.new,
              a
            )
          )
        )
      )
    )

    result = subject.run(program)

    expect(result).to be_satisfiable

    expect(result.fetch(a)).to eq(true)
    expect(result.fetch(b)).to eq(false)
    expect(result.fetch(c)).to eq(true)
  end

  specify do
    program = Sentient::Expression::Program.new(
      Sentient::Expression::Boolean::False.new
    )

    result = subject.run(program)
    expect(result).to_not be_satisfiable
  end
end
