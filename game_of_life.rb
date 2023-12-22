# frozen_string_literal: true

# Class to play the game of life
class GameOfLife
  attr_accessor :width, :height, :matrix, :flag, :alive_char, :dead_char

  def initialize(width, heigth, a_char = '██', d_char = '░░')
    @width = width
    @heigth = heigth
    @alive_char = a_char
    @dead_char = d_char
    @matrix = init_matrix
    @flag = 0
  end

  def init_matrix
    array = Array.new(@heigth) { Array.new(@width) }
    # matriz vacia
    (0...@width).each do |i|
      (0...@heigth).each do |j|
        array[i][j] = [@dead_char, @dead_char]
      end
    end
    array
  end

  def create(x, y = nil, state = @alive_char, flag = @flag)
    @matrix[y][x] = state unless y.nil?
    return unless x.is_a?(Array)

    x.each do |i|
      @matrix[i[1]][i[0]][flag] = state
    end
  end

  def count_neighbours(x, y, count = 0)
    directions = [-1, 0, 1]
    directions.each do |dx|
      directions.each do |dy|
        next if dx.zero? && dy.zero? # Skip the cell itself

        new_x = x + dx
        new_y = y + dy
        count += 1 if cell_alive?(new_y, new_x)
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

  def bucle
    loop do
      print "\n"
      show
      next_generation
      sleep(1)
    end
  end
end
