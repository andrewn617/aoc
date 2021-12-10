require_relative 'bingo'

RSpec.describe Bingo do
  let(:input) { File.read("input.txt") }

  subject(:bingo) { Bingo.new_from_string(input) }

  it "finds the winners score" do
    bingo.score!

    expect(bingo.score).to eq(39984)
  end
end