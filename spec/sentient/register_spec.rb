require "spec_helper"

RSpec.describe Sentient::Register do
  it "registers an arbitrary key with a unique number" do
    expect(described_class.fetch("a")).to eq(1)
    expect(described_class.fetch("b")).to eq(2)
    expect(described_class.fetch("a")).to eq(1)
  end

  it "automatically resets the register between tests" do
    expect(described_class.fetch("x")).to eq(1)
  end

  it "can be reset back to 1" do
    expect(described_class.fetch("a")).to eq(1)
    expect(described_class.fetch("b")).to eq(2)

    described_class.reset

    expect(described_class.fetch("c")).to eq(1)
  end

  it "can return the number of registered items" do
    described_class.fetch("a")
    expect(described_class.count).to eq(1)

    described_class.fetch("b")
    expect(described_class.count).to eq(2)

    described_class.fetch("a")
    expect(described_class.count).to eq(2)
  end
end
