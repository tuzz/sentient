require "spec_helper"

RSpec.describe Sentient::Expression::Program do
  it "enforces that the expression evaluate the true" do
    expression = described_class.new(
      Sentient::Expression::Boolean.new
    )

    expect(expression.to_dimacs).to eq [["1"]]
  end

  it "prepends the DIMACS for subexpressions" do
    expression = described_class.new(
      Sentient::Expression::Boolean::True.new
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["1"],
    ]
  end

  it "builds the DIMACS header" do
    expression = described_class.new(
      Sentient::Expression::Boolean::And.new(
        Sentient::Expression::Boolean::True.new,
        Sentient::Expression::Boolean::False.new
      )
    )

    expect(expression.header).to eq("p cnf 3 6\n")
  end
end
