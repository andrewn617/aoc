require_relative "diver"

RSpec.describe Diver do
  let(:input) { File.read("input.txt") }

  subject(:diver) { Diver.new(input) }

  it "dives to the correct position" do
    diver.dive

    expect(diver.depth * diver.horizontal).to eq(1714950)
  end
end