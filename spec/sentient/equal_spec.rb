require "spec_helper"

RSpec.describe Sentient::Equal do
  it "produces a DIMACS expression that is logically equivalent to 'xnor'" do
    expression = described_class.new(
      Sentient::Boolean.new,
      Sentient::Boolean.new
    )

    expect(expression.to_dimacs).to eq [
      ["1", "2", "3"],
      ["1", "-2", "-3"],
      ["-1", "2", "-3"],
      ["-1", "-2", "3"],
    ]
    expect(expression.boolean).to eq("3")
  end

  it "prepends the DIMACS for subexpressions" do
    expression = described_class.new(
      Sentient::True.new,
      Sentient::False.new
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["-2"],
      ["1", "2", "3"],
      ["1", "-2", "-3"],
      ["-1", "2", "-3"],
      ["-1", "-2", "3"],
    ]
  end
end

