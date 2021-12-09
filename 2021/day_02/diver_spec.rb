require_relative "diver"

RSpec.describe Diver do
  let(:input) { File.read("input.txt") }

  it "dives to the correct position" do
    diver = Diver.new(input)

    diver.execute_dive

    expect(diver.position).to eq(1714950)
  end

  it "can consider aim when diving" do
    diver = Diver.new(input, type: :with_aim)

    diver.execute_dive

    expect(diver.position).to eq(1281977850)
  end
end