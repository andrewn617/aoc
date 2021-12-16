class PopulationModel
  attr_reader :current_population

  def self.from_string(string)
    initial_state = string.split(",").map(&:to_i)

    new(initial_state)
  end

  def initialize(initial_state)
    @current_population = initial_state.tally
  end

  def tick(amount = 1)
    amount.times { tick_once }
  end

  def population
    current_population.values.sum
  end

  private

  def tick_once
    new_population = current_population.transform_keys { |k| k - 1 }

    new_population.default = 0

    spawning_count = new_population.delete(-1) || 0
    new_population[6] += spawning_count
    new_population[8] = spawning_count

    @current_population = new_population
  end
end
