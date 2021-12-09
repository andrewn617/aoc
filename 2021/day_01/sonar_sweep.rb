class SonarSweep
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculate_slope(window: 1)
    measurement_windows(window).each_cons(2).count { |first, second| second.sum > first.sum }
  end

  private

  def measurement_windows(size)
    depth_measurements.each_cons(size).to_a
  end

  def depth_measurements
    @_depth_measurements ||= input.split("\n").map(&:to_i)
  end
end
