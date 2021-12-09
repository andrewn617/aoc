class BinaryDiagnostic
  def initialize(input)
    @input = input
  end

  def gamma
    most_occurences.to_i(2)
  end

  def epsilon
    least_occurences.to_i(2)
  end

  private

  def most_occurences
    @_most_common_bit ||= bit_matrix
      .transpose
      .map { |column| column.sum(&:to_i) > column.size / 2 ? 0 : 1 }
      .join
  end

  def least_occurences
    most_occurences.tr("01", "10")
  end

  def bit_matrix
    @_bit_matrix ||= @input.split("\n").map(&:chars)
  end
end