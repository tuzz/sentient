require "spec_helper"

RSpec.describe Sentient::Expression::Boolean do
  it "associates an auto-incrementing number with the boolean" do
    expect(described_class.new).to eq("1")
    expect(described_class.new).to eq("2")
  end

  it "resets the auto-increment back to 1 between tests" do
    expect(subject).to eq("1")
  end

  it "can be negated to return the negative of the number" do
    expect(subject.negate).to eq("-1")
  end

  it "does not mutate the original object after calling negate" do
    subject.negate
    expect(subject).to eq("1")
  end

  it "supports the chaining of negate" do
    expect(subject.negate.negate).to eq("1")
  end

  it "is the base case for DIMACS compilation" do
    expect(subject.to_dimacs).to eq []
    expect(subject.boolean).to eq(subject)
  end

  it "provides a mechanism to get the number of instantiated booleans" do
    described_class.new
    described_class.new
    described_class.new

    expect(described_class.count).to eq(3)
  end
end
