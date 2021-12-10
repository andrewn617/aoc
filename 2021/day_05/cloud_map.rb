class CloudMap
  attr_reader :cords

  def self.from_string(string)
    cord_pairs = string.split("\n").map do |cords_string|
      cords_string.split(" -> ").map do |cord_strings|
        cord_strings.split(",").map(&:to_i)
      end
    end

    new(cord_pairs)
  end

  def initialize(cord_pairs)
    @cords = cord_pairs
  end

  def straight_line_hazards
    straight_lines
      .flatten(1)
      .tally
      .select { |_, v| v > 1 }
      .keys
  end

  def straight_lines
    straight_pairs.map do |start, finish|
      [start.first, finish.first].sort.inject(:upto).to_a.product([start.last, finish.last].sort.inject(:upto).to_a)
    end
  end

  def straight_pairs
    @_horizontal_lines ||= cords.select { |start, finish| start.first == finish.first || start.last == finish.last }
  end
end