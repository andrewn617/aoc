require_relative 'population_model'

RSpec.describe PopulationModel do
  let(:input) { File.read("input.txt") }

  it "models population for 80 days" do
    model = PopulationModel.from_string(input)

    model.tick(80)

    expect(model.population).to eq(353079)
  end

  it "models population for 256 days" do
    model = PopulationModel.from_string(input)

    model.tick(256)

    expect(model.population).to eq(1605400130036)
  end
end
