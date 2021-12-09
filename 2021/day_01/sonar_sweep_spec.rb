require_relative "sonar_sweep"

RSpec.describe SonarSweep do
  let(:input) { File.read("input.txt") }

  subject(:sonar_sweep) { SonarSweep.new(input) }

  it "calculates depth increase" do
    slope = sonar_sweep.calculate_slope

    expect(slope).to eq(1462)
  end

  it "calculates depth increase for a window of 3" do
    slope = sonar_sweep.calculate_slope(window: 3)

    expect(slope).to eq(1497)
  end
end