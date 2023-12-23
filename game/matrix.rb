# frozen_string_literal: false

require_relative 'cells'
# class to create the matrix
class Matrix < Cells
  attr_accessor :matrix, :width, :heigth, :flag

  def initialize(width, heigth, a_char, d_char)
    super(a_char, d_char)
    @width = width
    @heigth = heigth

    @flag = 0
    @matrix = init_matrix(@heigth, @width, @dead_char)
  end

  def init_matrix(heigth, width, dead_char)
    array = Array.new(heigth) { Array.new(width) }
    (0...width).each do |i|
      (0...heigth).each do |j|
        array[i][j] = [dead_char, dead_char]
      end
    end
    array
  end

  def create_cells(x, y = nil, state = @alive_char, flag = @flag)
    @matrix[y][x] = state unless y.nil?
    return unless x.is_a?(Array)

    x.each do |i|
      @matrix[i[1]][i[0]][flag] = state
    end
  end
end
