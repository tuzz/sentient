require "spec_helper"

RSpec.describe Sentient::False do
  it "enforces that the boolean is false" do
    expression = described_class.new

    expect(expression.to_dimacs).to eq [["-1"]]
    expect(expression.boolean).to eq("1")
  end
end
