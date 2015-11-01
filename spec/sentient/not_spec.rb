require "spec_helper"

RSpec.describe Sentient::Not do
  it "produces a DIMACS expression that is logically equivalent to 'not'" do
    expression = described_class.new(
      Sentient::Boolean.new
    )

    expect(expression.to_dimacs).to eq [
      ["-1", "-2"],
      ["1", "2"],
    ]
    expect(expression.boolean).to eq("2")
  end

  it "prepends the DIMACS for subexpressions" do
    expression = described_class.new(
      Sentient::True.new
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["-1", "-2"],
      ["1", "2"]
    ]
  end
end
