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

  def life_support_rating
    bits = bit_matrix.map { |bits| bits.map(&:to_i) }

    co2_rating(bits) * oxy_rating(bits)
  end

  def co2_rating(matrix, column_number = 0)
    column = matrix.transpose[column_number]
    most_common_bit = if column.sum == column.size / 2.0
                        1
                      else
                        column.sum > column.size / 2 ? 1 : 0
                      end

    with_common_bit = matrix.partition { |bits| bits[column_number] == most_common_bit }.first

    if with_common_bit.size == 1
      with_common_bit.flatten.join.to_i(2)
    else
      co2_rating(with_common_bit, column_number + 1)
    end
  end

  def oxy_rating(matrix, column_number = 0)
    column = matrix.transpose[column_number]
    most_common_bit = if column.sum == column.size / 2.0
                        0
                      else
                        column.sum > column.size / 2 ? 0 : 1
                      end

    with_common_bit = matrix.partition { |bits| bits[column_number] == most_common_bit }.first

    if with_common_bit.size == 1
      with_common_bit.flatten.join.to_i(2)
    else
      oxy_rating(with_common_bit, column_number + 1)
    end
  end

  private

  def most_occurences
    @_most_common_bit ||= columns
      .map { |column| column.sum(&:to_i) > column.size / 2.0 ? 1 : 0 }
      .join
  end

  def least_occurences
    most_occurences.tr("01", "10")
  end

  def columns
    @_columns ||= bit_matrix.transpose
  end

  def bit_matrix
    @_bit_matrix ||= @input.split("\n").map(&:chars)
  end
end