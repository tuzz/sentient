require "spec_helper"

RSpec.describe Sentient::Expression::Boolean::And do
  it "produces a DIMACS expression that is logically equivalent to 'and'" do
    expression = described_class.new(
      Sentient::Expression::Boolean.new,
      Sentient::Expression::Boolean.new
    )

    expect(expression.to_dimacs).to eq [
      ["-1", "-2", "3"],
      ["1", "-3"],
      ["2", "-3"],
    ]
    expect(expression.boolean).to eq("3")
  end

  it "prepends the DIMACS for subexpressions" do
    expression = described_class.new(
      Sentient::Expression::Boolean::True.new,
      Sentient::Expression::Boolean::False.new
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["-2"],
      ["-1", "-2", "3"],
      ["1", "-3"],
      ["2", "-3"],
    ]
  end
end
