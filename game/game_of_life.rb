# frozen_string_literal: false

require_relative 'matrix'

# Class to play the game of life
class GameOfLife < Matrix
  attr_accessor :display

  def initialize(width, heigth, a_char = '██', d_char = '░░')
    super(width, heigth, a_char, d_char)
  end

  def next_generation
    (0...@width).each do |y|
      (0...@heigth).each do |x|
        @matrix[y][x][@flag.abs - 1] = rules(x, y)
      end
    end

    @flag = @flag == 1 ? 0 : 1
  end

  def rules(x_pos, y_pos)
    neighbours = count_neighbours(x_pos, y_pos)
    return @alive_char if !cell_alive?(x_pos, y_pos) && (neighbours == 3)

    return @dead_char unless cell_alive?(x_pos, y_pos)

    [2, 3].include?(neighbours) ? @alive_char : @dead_char
  end

  def show
    @matrix.each do |i|
      i.each do |j|
        print j[@flag]
      end
      print "\n"
    end
  end

  def start
    loop do
      print "\n"
      show
      next_generation
      sleep(0.5)
    end
  end
end
