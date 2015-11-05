require "spec_helper"

RSpec.describe Sentient::Expression::Integer::Add do
  let(:solver) { Sentient::Solver::Lingeling.new("lingeling") }
  let(:machine) { Sentient::Machine.new(solver) }

  it "compiles to DIMACS by using a series of adders" do
    expression = described_class.new(
      Sentient::Expression::Integer::Literal.new(0),
      Sentient::Expression::Integer::Literal.new(0)
    )

    expect(expression.to_dimacs).to eq [
      # 0
      ["-1"],
      ["-2"],

      # 0
      ["-3"],
      ["-4"],

      # 5 := xor bit 1
      ["-1", "-3", "-5"],
      ["1", "3", "-5"],
      ["1", "-3", "5"],
      ["-1", "3", "5"],

      # false
      ["-6"],

      # 7 := sum bit 1         <--- bit 1 output
      ["-5", "-6", "-7"],
      ["5", "6", "-7"],
      ["5", "-6", "7"],
      ["-5", "6", "7"],

      # 8 := xor bit 2
      ["-2", "-4", "-8"],
      ["2", "4", "-8"],
      ["2", "-4", "8"],
      ["-2", "4", "8"],

      # 9 := and bit 1
      ["-1", "-3", "9"],
      ["1", "-9"],
      ["3", "-9"],

      # 10 := xor bit 1
      ["-1", "-3", "-10"],
      ["1", "3", "-10"],
      ["1", "-3", "10"],
      ["-1", "3", "10"],

      # 11 := and carry with xor bit 1
      ["-6", "-10", "11"],
      ["6", "-11"],
      ["10", "-11"],

      # 12 := carry bit 1
      ["9", "11", "-12"],
      ["-9", "12"],
      ["-11", "12"],

      # 13 := sum bit 2          <-- bit 2 output
      ["-8", "-12", "-13"],
      ["8", "12", "-13"],
      ["8", "-12", "13"],
      ["-8", "12", "13"],

      # 14 := and bit 2
      ["-2", "-4", "14"],
      ["2", "-14"],
      ["4", "-14"],

      # 15 := xor bit 2
      ["-2", "-4", "-15"],
      ["2", "4", "-15"],
      ["2", "-4", "15"],
      ["-2", "4", "15"],

      # 16 := and carry with xor bit 2
      ["-12", "-15", "16"],
      ["12", "-16"],
      ["15", "-16"],

      # 16 := carry bit 2        <-- bit 3 output
      ["14", "16", "-17"],
      ["-14", "17"],
      ["-16", "17"]
    ]
    expect(expression.integer).to eq ["7", "13", "17"]
  end

  it "adds positive integers correctly" do
    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(7),
          Sentient::Expression::Integer::Literal.new(31)
        ),
        answer = Sentient::Expression::Integer.new(8)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [false, true, true, false, false, true, false, false]
                       #        0     1     1      0     0      1     0       0 = 38


    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(1234),
          Sentient::Expression::Integer::Literal.new(456789)
        ),
        answer = Sentient::Expression::Integer.new(20)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [
      true, true, true, false, false, true, false, false, # 39
      true, false, true, true, true, true, true, true,    # 64768
      false, true, true, false                            # 393216

                                                          # = 458023
    ]
  end

  it "adds negative integers correctly" do
    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(-7),
          Sentient::Expression::Integer::Literal.new(-31)
        ),
        answer = Sentient::Expression::Integer.new(8)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [false, true, false, true, true, false, true, true]


    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(-1234),
          Sentient::Expression::Integer::Literal.new(-456789)
        ),
        answer = Sentient::Expression::Integer.new(20)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [
      true, false, false, true, true, false, true, true,
      false, true, false, false, false, false, false, false,
      true, false, false, true
    ] # = -458023
  end

  it "adds positive and negative integers correctly" do
    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(7),
          Sentient::Expression::Integer::Literal.new(-31)
        ),
        answer = Sentient::Expression::Integer.new(8)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [
      false, false, false, true, false, true, true, true
    ]


    program = Sentient::Expression::Program.new(
      Sentient::Expression::Integer::Equal.new(
        described_class.new(
          Sentient::Expression::Integer::Literal.new(-7),
          Sentient::Expression::Integer::Literal.new(31)
        ),
        answer = Sentient::Expression::Integer.new(8)
      )
    )

    result = machine.run(program)
    expect(result).to be_satisfiable
    booleans = answer.booleans.map { |x| result.fetch(x) }

    expect(booleans).to eq [
      false, false, false, true, true, false, false, false
    ]
  end
end
