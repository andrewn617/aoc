class Diver
  attr_reader :input, :depth, :horizontal, :aim

  def initialize(input, type: :no_aim)
    @input = input
    @depth = 0
    @horizontal = 0
    @aim = 0
    extend CommandInterpreters[type]
  end

  def execute_dive
    commands.each(&method(:execute))
  end

  def position
    depth * horizontal
  end

  private

  def commands
    @_commands ||= input.split("\n").map do |command_string|
      Command.from_string(command_string)
    end
  end

  def execute(command)
    send(command.direction, command.unit)
  end
end

class Command
  attr_reader :direction, :unit

  DIRECTIONS = [
    :forward,
    :down,
    :up
  ]

  def self.from_string(string)
    direction, unit = string.split(" ")

    new(direction.to_sym, unit.to_i)
  end

  def initialize(direction, unit)
    raise DirectionError unless DIRECTIONS.include?(direction)
    @direction = direction
    @unit = unit
  end

  DirectionError = Class.new
end

module CommandInterpreters
  module NoAimInterpreter
    def forward(unit)
      @horizontal += unit
    end

    def down(unit)
      @depth += unit
    end

    def up(unit)
      @depth -= unit
    end
  end

  module WithAimInterpreter
    def forward(unit)
      @horizontal += unit
      @depth += aim * unit
    end

    def down(unit)
      @aim += unit
    end

    def up(unit)
      @aim -= unit
    end
  end

  DIRECTORY = {
    no_aim: NoAimInterpreter,
    with_aim: WithAimInterpreter
  }

  def self.[](type)
    DIRECTORY[type]
  end
end
