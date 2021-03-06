class Bingo
  attr_reader :draws, :boards

  def self.new_from_string(string)
    draws_string, *board_strings = string.split("\n\n")
    draws = draws_string.split(",").map(&:to_i)
    boards = board_strings.map { |board_string| Board.new_from_string(board_string) }

    new(draws, boards)
  end

  def initialize(draws, boards)
    @draws = draws
    @boards = boards
  end

  def score!
    draws.each do |draw|
      boards.each { |board| board.mark_draw!(draw) }
    end
  end

  def winning_score
    winners.first.score
  end

  def winners
    boards.select(&:won?).sort
  end
end

class Board
  attr_reader :layout, :draws

  def self.new_from_string(string)
    layout = string.split("\n").map do |row|
      row.split(" ").map(&:to_i)
    end

    new(layout)
  end

  def initialize(layout)
    @layout = layout
    @draws = []
  end

  def <=>(other)
    draws.size <=> other.draws.size
  end

  def mark_draw!(draw)
    return if won?

    draws << draw

    y, x = find_index(draw)

    return if y.nil?

    @layout[y][x] = nil
  end

  def won?
    return true if layout.any? { |board| board.all?(&:nil?) }
    return true if layout.transpose.any? { |board| board.all?(&:nil?) }
  end

  def score
    return 0 unless won?

    layout.flatten.compact.sum * draws.last
  end

  private

  def find_index(draw)
    layout.filter_map.with_index do |row, i|
      [i, row.index(draw)] if row.include?(draw)
    end.first
  end
end