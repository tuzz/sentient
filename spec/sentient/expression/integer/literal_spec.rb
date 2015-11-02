require "spec_helper"

RSpec.describe Sentient::Expression::Integer::Literal do
  it "supports positive integers in twos-complement encoding" do
    expression = described_class.new(5)

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["-2"],
      ["3"],
      ["-4"],
    ]
    expect(expression.integer).to eq ["1", "2", "3", "4"]
  end

  it "supports negative integers in twos-complement encoding" do
    expression = described_class.new(-5)

    expect(expression.to_dimacs).to eq [
      ["1"],
      ["2"],
      ["-3"],
      ["4"],
    ]
    expect(expression.integer).to eq ["1", "2", "3", "4"]
  end

  it "allocates just enough bits to store the literal" do
    expression = described_class.new(100)

    expect(expression.to_dimacs).to eq [
      ["-1"],
      ["-2"],
      ["3"],
      ["-4"],
      ["-5"],
      ["6"],
      ["7"],
      ["-8"],
    ]
    expect(expression.integer).to eq ["1", "2", "3", "4", "5", "6", "7", "8"]
  end

  it "represents zero correctly" do
    expression = described_class.new(0)

    expect(expression.to_dimacs).to eq [
      ["-1"],
      ["-2"],
    ]
    expect(expression.integer).to eq ["1", "2"]
  end
end
