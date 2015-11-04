require "spec_helper"

RSpec.describe Sentient::Expression::Boolean::Identity do
  it "binds two booleans together and enforces they are equal" do
    expression = described_class.new(
      Sentient::Expression::Boolean::True.new
    )

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["1", "-2"],
      ["-1", "2"],
    ]
    expect(expression.boolean).to eq("2")
  end
end
