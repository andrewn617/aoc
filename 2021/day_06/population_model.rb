class PopulationModel
  attr_reader :current_state

  def self.from_string(string)
    initial_state = string.split(",").map(&:to_i)

    new(initial_state)
  end

  def initialize(initial_state)
    @current_state = initial_state
  end

  def tick(amount = 1)
    amount.times { tick_once }
  end

  def population
    current_state.count
  end

  private

  def tick_once
    @current_state = current_state.flat_map do |timer|
      new = timer - 1

      new.negative? ? [6, 8] : new
    end
  end
end