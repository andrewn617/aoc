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
    SystemRater.co2_scrubber(readings) * SystemRater.oxygen_generator(readings)
  end

  private

  def most_occurences
    @_most_common_bit ||= columns
      .map { |column| column.sum > column.size / 2 ? 1 : 0 }
      .join
  end

  def least_occurences
    most_occurences.tr("01", "10")
  end

  def columns
    @_columns ||= readings.transpose
  end

  def readings
    @_readings ||= @input.split("\n").map { |bits| bits.chars.map(&:to_i) }
  end
end


class SystemRater
  attr_reader :fallback

  def self.co2_scrubber(readings)
    new(readings.dup, 1).rate
  end

  def self.oxygen_generator(readings)
    new(readings.dup, 0).rate
  end

  def initialize(readings, fallback)
    @readings = readings
    @fallback = fallback
  end

  def rate(column_number = 0)
    return rating if rating_available?

    column = columns[column_number]

    target_bit = if column.sum == column.size / 2.0
                   fallback
                 else
                   column.sum > column.size / 2 ? fallback : other
                 end

    readings.select! { |bits| bits[column_number] == target_bit }

    rate(column_number + 1)
  end

  private

  attr_reader :readings

  def other
    fallback == 1 ? 0 : 1
  end

  def columns
    readings.transpose
  end

  def rating
    readings.join.to_i(2)
  end

  def rating_available?
    readings.one?
  end
end