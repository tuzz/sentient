require "spec_helper"

RSpec.describe Sentient::Solver::Lingeling do
  subject { described_class.new("lingeling") }

  it "solves a given DIMACS program" do
    result = subject.solve("p cnf 4 4\n", [
      ["1"],
      ["-2"],
      ["3"],
      ["-4"],
    ])

    expect(result).to be_satisfiable

    expect(result.fetch("1")).to eq(true)
    expect(result.fetch("2")).to eq(false)
    expect(result.fetch("3")).to eq(true)
    expect(result.fetch("4")).to eq(false)
  end

  it "reports that programs are unsatisfiable" do
    result = subject.solve("p cnf 1 2\n", [
      ["1"],
      ["-1"],
    ])

    expect(result).to_not be_satisfiable
    expect(result.fetch("1")).to eq(nil)
  end
end
