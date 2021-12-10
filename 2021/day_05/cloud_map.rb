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
    diagonal_pairs.map do |start, finish|
      [[start.first, finish.first], [start.last, finish.last]].map do |start_cord, finish_cord|
        direction = start_cord < finish_cord ? :upto : :downto

        start_cord.send(direction, finish_cord).to_a
      end.inject(:zip)
    end
  end

  def straight_lines
    straight_pairs.map do |start, finish|
      [start.first, finish.first].sort.inject(:upto).to_a.product([start.last, finish.last].sort.inject(:upto).to_a)
    end
  end

  def diagonal_pairs
    @_diagonal_pairs ||= cord_pairs - straight_pairs
  end

  def straight_pairs
    @_horizontal_lines ||= cord_pairs.select { |start, finish| start.first == finish.first || start.last == finish.last }
  end
end