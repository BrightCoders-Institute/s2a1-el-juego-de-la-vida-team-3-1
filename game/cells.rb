# frozen_string_literal: false

require_relative 'game_of_life'

# Class to check and modify the cells
class Cells
  attr_accessor :alive_char, :dead_char

  def initialize(a_char, d_char)
    @alive_char = a_char
    @dead_char = d_char
  end

  def count_neighbours(x, y)
    count = 0
    directions = [-1, 0, 1]

    directions.each do |dx|
      directions.each do |dy|
        next if dx == 0 && dy == 0 # Skip the cell itself

        nx = x + dx
        ny = y + dy

        # Check if the neighbor is within the grid
        if nx >= 0 && nx < @matrix[0].length && ny >= 0 && ny < @matrix.length && (@matrix[ny][nx][@flag] == @alive_char)
          count += 1
        end
      end
    end

    count
  end

  def cell_alive?(x_pos, y_pos)
    within_grid?(x_pos, y_pos) && @matrix[y_pos][x_pos][@flag] == @alive_char
  end

  def within_grid?(x_pos, y_pos)
    x_pos.between?(0, @matrix[0].length - 1) && y_pos.between?(0, @matrix.length - 1)
  end
end
