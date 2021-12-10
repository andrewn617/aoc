class CloudMap
  attr_reader :cord_pairs

  def self.from_string(string)
    cord_pairs = string.split("\n").map do |cords_string|
      cords_string.split(" -> ").map do |cord_strings|
        cord_strings.split(",").map(&:to_i)
      end
    end

    new(cord_pairs)
  end

  def initialize(cord_pairs)
    @cord_pairs = cord_pairs
  end

  def all_hazards
    all_lines
      .flatten(1)
      .tally
      .select { |_, v| v > 1 }
      .keys
  end

  def straight_line_hazards
    straight_lines
      .flatten(1)
      .tally
      .select { |_, v| v > 1 }
      .keys
  end

  private

  def all_lines
    diagonal_lines + straight_lines
  end

  def diagonal_lines
    diagonal_pairs.map do |cord_pair|
      cord_pair.transpose.map(&method(:numbers_between)).transpose
    end
  end

  def straight_lines
    straight_pairs.map do |cord_pair|
      cord_pair.transpose.map(&method(:numbers_between)).inject(:product)
    end
  end

  def numbers_between(ordered_pair)
    first, last = ordered_pair

    direction = first < last ? :upto : :downto

    first.send(direction, last).to_a
  end

  def diagonal_pairs
    @_diagonal_pairs ||= cord_pairs - straight_pairs
  end

  def straight_pairs
    @_horizontal_lines ||= cord_pairs.select { |start, finish| start.first == finish.first || start.last == finish.last }
  end
end