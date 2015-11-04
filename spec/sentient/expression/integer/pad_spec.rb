require "spec_helper"

RSpec.describe Sentient::Expression::Integer::Pad do
  it "pads positive integers up to a given width" do
    expression = described_class.new(
      Sentient::Expression::Integer::Literal.new(1),
      3
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["-2"], # <-- sign
      ["2", "-3"],
      ["-2", "3"],
    ]
    expect(expression.integer.booleans).to eq ["1", "3", "2"]
  end

  it "pads negative integers up to a given width" do
    expression = described_class.new(
      Sentient::Expression::Integer::Literal.new(-2),
      5
    )

    expect(expression.to_dimacs).to eq [
      ["-1"],
      ["2"],
      ["3"], # <-- sign
      ["3", "-4"],
      ["-3", "4"],
      ["3", "-5"],
      ["-3", "5"],
    ]
    expect(expression.integer.booleans).to eq ["1", "2", "4", "5", "3"]
  end

  it "has no effect if the width is equal to the width of the integer" do
    expression = described_class.new(
      Sentient::Expression::Integer::Literal.new(15),
      5
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["2"],
      ["3"],
      ["4"],
      ["-5"],
    ]
    expect(expression.integer.booleans).to eq ["1", "2", "3", "4", "5"]
  end

  it "raises an error if the width is less than the width of the integer" do
    expect {
      described_class.new(
        Sentient::Expression::Integer::Literal.new(15),
        4
      )
    }.to raise_error(ArgumentError, /5/)
  end
end
