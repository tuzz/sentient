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

  it "can find three numbers that add up to 100" do
    a = Sentient::Expression::Integer.new(8)
    b = Sentient::Expression::Integer.new(8)
    c = Sentient::Expression::Integer.new(8)

    added = Sentient::Expression::Integer::Add.new(
      a,
      Sentient::Expression::Integer::Add.new(
        b,
        c
      )
    )

    equal_100 = Sentient::Expression::Integer::Equal.new(
      added,
      Sentient::Expression::Integer::Literal.new(100)
    )

    program = Sentient::Expression::Program.new(equal_100)
    result = subject.run(program)

    expect(result).to be_satisfiable

    a_result = a.integer.booleans.map { |x| result.fetch(x) }
    b_result = b.integer.booleans.map { |x| result.fetch(x) }
    c_result = c.integer.booleans.map { |x| result.fetch(x) }

    expect(a.integer.to_ruby(result)).to eq(127)
    expect(b.integer.to_ruby(result)).to eq(-14)
    expect(c.integer.to_ruby(result)).to eq(-13)
  end

  it "can find three numbers that add up to 100 and 5 numbers that add up to 1000" do
    a = Sentient::Expression::Integer.new(10)
    b = Sentient::Expression::Integer.new(10)
    c = Sentient::Expression::Integer.new(10)
    d = Sentient::Expression::Integer.new(10)
    e = Sentient::Expression::Integer.new(10)

    add_ace = Sentient::Expression::Integer::Add.new(
      a,
      Sentient::Expression::Integer::Add.new(
        c,
        e
      )
    )

    add_all = Sentient::Expression::Integer::Add.new(
      add_ace,
      Sentient::Expression::Integer::Add.new(
        b,
        d
      )
    )

    equal_100 = Sentient::Expression::Integer::Equal.new(
      add_ace,
      Sentient::Expression::Integer::Literal.new(100)
    )

    equal_1000 = Sentient::Expression::Integer::Equal.new(
      add_all,
      Sentient::Expression::Integer::Literal.new(1000)
    )

    program = Sentient::Expression::Program.new(
      Sentient::Expression::Boolean::And.new(
        equal_100,
        equal_1000
      )
    )

    result = subject.run(program)
    expect(result).to be_satisfiable

    a_result = a.integer.booleans.map { |x| result.fetch(x) }
    b_result = b.integer.booleans.map { |x| result.fetch(x) }
    c_result = c.integer.booleans.map { |x| result.fetch(x) }
    d_result = d.integer.booleans.map { |x| result.fetch(x) }
    e_result = e.integer.booleans.map { |x| result.fetch(x) }

    expect(a.integer.to_ruby(result)).to eq(487)
    expect(b.integer.to_ruby(result)).to eq(446)
    expect(c.integer.to_ruby(result)).to eq(-2)
    expect(d.integer.to_ruby(result)).to eq(454)
    expect(e.integer.to_ruby(result)).to eq(-385)
  end
end
