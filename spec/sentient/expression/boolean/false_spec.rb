require "spec_helper"

RSpec.describe Sentient::Expression::Boolean::False do
  it "enforces that the boolean is false" do
    expression = described_class.new

    expect(expression.to_dimacs).to eq [["-1"]]
    expect(expression.boolean).to eq("1")
  end

  it "is a singleton and uses the same number each time" do
    expect(described_class.new.boolean).to eq("1")
    expect(described_class.new.boolean).to eq("1")
  end

  it "respects register resets, just like everything else" do
    Sentient::Expression::Boolean::True.new.boolean

    expect(described_class.new.boolean).to eq("2")
    expect(described_class.new.boolean).to eq("2")

    Sentient::Register.reset

    expect(described_class.new.boolean).to eq("1")
    expect(described_class.new.boolean).to eq("1")
  end
end
