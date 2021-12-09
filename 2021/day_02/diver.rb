require "singleton"

class Diver
  attr_reader :input, :depth, :horizontal, :interpreter

  def initialize(input, type: :no_aim)
    @input = input
    @depth = 0
    @horizontal = 0
    @interpreter = CommandInterpreterFactory.build(type)
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
    move = interpreter.send(command.direction, command.unit)

    @depth += move.depth
    @horizontal += move.horizontal
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

class NoAimInterpreter
  def forward(unit)
    MoveFactory.build(horizontal: unit)
  end

  def down(unit)
    MoveFactory.build(depth: unit)
  end

  def up(unit)
    MoveFactory.build(depth: -unit)
  end
end

class WithAimInterpreter
  def initialize
    @aim = 0
  end

  def forward(unit)
    MoveFactory.build(
      horizontal: unit,
      depth: @aim * unit
    )
  end

  def down(unit)
    @aim += unit

    MoveFactory.build
  end

  def up(unit)
    @aim -= unit

    MoveFactory.build
  end
end

module MoveFactory
  def self.build(depth: 0, horizontal: 0)
    return NoOpMove.instance if depth.zero? && horizontal.zero?

    Move.new(depth: depth, horizontal: horizontal)
  end
end

class Move
  attr_reader :depth, :horizontal

  def initialize(depth: 0, horizontal: 0)
    @depth = depth
    @horizontal = horizontal
  end
end

class NoOpMove
  include Singleton

  def depth
    0
  end

  def horizontal
    0
  end
end

module CommandInterpreterFactory
  DIRECTORY = {
    no_aim: NoAimInterpreter,
    with_aim: WithAimInterpreter
  }

  def self.build(type)
    DIRECTORY[type].new
  end
end

