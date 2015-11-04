require "spec_helper"

RSpec.describe Sentient::Expression::Boolean::True do
  it "enforces that the boolean is true" do
    expression = described_class.new

    expect(expression.to_dimacs).to eq [["1"]]
    expect(expression.boolean).to eq("1")
  end
end
