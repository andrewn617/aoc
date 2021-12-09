require_relative "binary_diagnostic"

RSpec.describe BinaryDiagnostic do
  let(:input) { File.read("input.txt") }

  subject(:diagnostic) { BinaryDiagnostic.new(input) }

  it "calculates the correct gamma and epsilon rates" do
    expect(diagnostic.gamma * diagnostic.epsilon).to eq(2954600)
  end

  it "calculates the life support rating" do
    expect(diagnostic.life_support_rating).to eq(1662846)
  end
end