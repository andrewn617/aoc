class BinaryDiagnostic
  def initialize(input)
    @input = input
  end

  def gamma
    bit_matrix
      .transpose
      .map { |column| column.sum(&:to_i) > column.size / 2 ? 1 : 0 }
      .join
      .to_i(2)
  end

  def epsilon
    bit_matrix
      .transpose
      .map { |column| column.sum(&:to_i) > column.size / 2 ? 0 : 1 }
      .join
      .to_i(2)
  end

  private

  def bit_matrix
    @_bit_matrix ||= @input.split("\n").map(&:chars)
  end
end