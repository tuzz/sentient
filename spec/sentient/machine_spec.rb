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

  describe "google doodle for George Boole" do
    let(:x) { Sentient::Expression::Boolean.new }
    let(:y) { Sentient::Expression::Boolean.new }

    let(:g) { Sentient::Expression::Boolean::And.new(x, y) }
    let(:o1) { Sentient::Expression::Boolean::Xor.new(x, y) }
    let(:o2) { Sentient::Expression::Boolean::Or.new(x, y) }
    let(:l) { Sentient::Expression::Boolean::Not.new(y) }
    let(:e) { Sentient::Expression::Boolean::Not.new(x) }

    it "is not possible to light up every character in google" do
      program = Sentient::Expression::Program.new(
        Sentient::Expression::Boolean::And.new(
          g,
          Sentient::Expression::Boolean::And.new(
            o1,
            Sentient::Expression::Boolean::And.new(
              o2,
              Sentient::Expression::Boolean::And.new(
                l,
                e
              )
            )
          )
        )
      )

      result = subject.run(program)
      expect(result).to_not be_satisfiable
    end

    it "is possible to light up the two 'o' letters at the same time" do
      program = Sentient::Expression::Program.new(
        Sentient::Expression::Boolean::And.new(o1, o2)
      )

      result = subject.run(program)
      expect(result).to be_satisfiable

      expect(result.fetch(x)).to eq(true)
      expect(result.fetch(y)).to eq(false)
    end
  end
end
