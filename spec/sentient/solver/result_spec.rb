require "spec_helper"

RSpec.describe Sentient::Solver::Result do
  context "when the program is satisfiable" do
    subject { described_class.new([1, -2, 3]) }

    it "reports that it is satisfiable" do
      expect(subject).to be_satisfiable
    end

    it "returns the correct assignments" do
      expect(subject.fetch("1")).to eq(true)
      expect(subject.fetch("2")).to eq(false)
      expect(subject.fetch("3")).to eq(true)
    end
  end

  context "when the program is not satisfiable" do
    subject { described_class.new([]) }

    it "reports that it is not satisfiable" do
      expect(subject).to_not be_satisfiable
    end

    it "returns nil for any assignment" do
      expect(subject.fetch("1")).to eq(nil)
    end
  end
end
