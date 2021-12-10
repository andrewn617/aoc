require_relative "cloud_map"

RSpec.describe CloudMap do
  let(:input) { File.read("input.txt") }

  subject(:cloud_map) { CloudMap.from_string(input)}

  it "finds vertical and horizontal hazards" do
    expect(cloud_map.straight_line_hazards.count).to eq(5698)
  end

  it "finds all hazards" do
    expect(cloud_map.all_hazards.count).to eq(15463)
  end
end