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

  it "calculates the life support rating easier" do
    input = <<~TXT
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    TXT

    diagnostic = BinaryDiagnostic.new(input)

    expect(diagnostic.life_support_rating).to eq(230)
  end
end