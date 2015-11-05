require "spec_helper"

RSpec.describe Sentient::Expression::Integer do
  subject { described_class.new(3) }

  it "associates an array of auto-incrementing numbers with the integer" do
    expect(subject).to eq ["1", "2", "3"]
  end

  it "is the base case for DIMACS compilation" do
    expect(subject.to_dimacs).to eq []
    expect(subject.integer).to eq(subject)
  end

  it "provides access to its booleans" do
    expect(subject.booleans).to eq ["1", "2", "3"]
  end

  it "can be instantiated with provided booleans" do
    booleans = [
      Sentient::Expression::Boolean.new,
      Sentient::Expression::Boolean.new
    ]
    subject = described_class.new(booleans)

    expect(subject.booleans).to eq(booleans)
  end

  it "can turn an integer back into ruby given the result" do
    result = Sentient::Solver::Result.new([-1, -2, -3])
    expect(subject.to_ruby(result)).to eq(0)

    result = Sentient::Solver::Result.new([1, -2, -3])
    expect(subject.to_ruby(result)).to eq(1)

    result = Sentient::Solver::Result.new([1, 2, -3])
    expect(subject.to_ruby(result)).to eq(3)

    result = Sentient::Solver::Result.new([1, 2, 3])
    expect(subject.to_ruby(result)).to eq(-1)

    result = Sentient::Solver::Result.new([1, -2, 3])
    expect(subject.to_ruby(result)).to eq(-3)
  end
end
