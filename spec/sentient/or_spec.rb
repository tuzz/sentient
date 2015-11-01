require "spec_helper"

RSpec.describe Sentient::Or do
  it "produces a DIMACS expression that is logically equivalent to 'or'" do
    expression = described_class.new(
      Sentient::Boolean.new,
      Sentient::Boolean.new
    )

    expect(expression.to_dimacs).to eq [
      ["1", "2", "-3"],
      ["-1", "3"],
      ["-2", "3"],
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
      ["1", "2", "-3"],
      ["-1", "3"],
      ["-2", "3"],
    ]
  end
end
