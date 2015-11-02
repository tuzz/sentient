require "spec_helper"

RSpec.describe Sentient::Expression::Integer do
  it "associates an array of auto-incrementing numbers with the integer" do
    expect(described_class.new).to eq ["1", "2"]
    expect(described_class.new).to eq ["3", "4"]
  end

  it "has a precision of the provided number of bits (plus one for the sign)" do
    expect(described_class.new(3)).to eq ["1", "2", "3", "4"]
  end

  it "compiles down to DIMACS for the internal booleans" do
    expect(subject.to_dimacs).to eq [["1"], ["2"]]
    expect(subject.integer).to eq(subject)
  end

  it "supports setting individual bits of the integer" do
    integer = described_class.new(3)

    integer = integer.set(0, false)
    integer = integer.set(2, false)
    integer = integer.set(3, false)

    expect(integer).to eq ["-1", "2", "-3", "-4"]
  end

  it "does not mutate the original object after calling set" do
    subject.set(0, false)
    expect(subject).to eq ["1", "2"]
  end

  it "can negate positive numbers" do
    integer = described_class.new(3)

    integer = integer.set(0, true)
    integer = integer.set(1, false)
    integer = integer.set(2, false)
    integer = integer.set(3, false)

    expect(integer.negate).to eq ["1", "2", "3", "4"]
  end

  it "can negate negative numbers" do
    integer = described_class.new(3)

    integer = integer.set(0, true)
    integer = integer.set(1, false)
    integer = integer.set(2, false)
    integer = integer.set(3, true)

    expect(integer.negate).to eq ["1", "2", "3", "-4"]
  end

  it "can negate 0" do
    integer = described_class.new(1)

    integer = integer.set(0, false)
    integer = integer.set(1, false)

    expect(integer.negate).to eq ["-1", "-2"]
  end

  it "can negate -MAX_INT by increasing the precision" do
    integer = described_class.new(3)

    integer = integer.set(0, false)
    integer = integer.set(1, false)
    integer = integer.set(2, false)
    integer = integer.set(3, true)

    expect(integer.negate).to eq ["-1", "-2", "-3", "4", "-5"]
  end
end
