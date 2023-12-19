# frozen_string_literal: true

# puts "░░ ░░ ░░\n░░ ██ ░░\n██ ░░ ░░"
class Game
  attr_accessor :width, :height

  def initialize(width, heigth)
    @width = width
    @heigth = heigth
    @matrix = Array.new(@heigth) { Array.new(@width) }
    # matriz vacia
    (0...@width).each do |i|
      (0...@heigth).each do |j|
        @matrix[i][j] = ['░░', '░░']
      end
    end
  end

  def create(x, y = nil)
    @matrix[y][x] = '██' unless y.nil?
    return unless x.is_a?(Array)

    x.each do |i|
      @matrix[i[1]][i[0]][0] = '██'
    end
  end

  # alive_neighbours = [
  #   @grid.has_key?([x-1, y  ]), # left
  #   @grid.has_key?([x-1, y-1]), # Top Left
  #   @grid.has_key?([x  , y-1]), # Top
  #   @grid.has_key?([x+1, y-1]), # Top Right
  #   @grid.has_key?([x+1, y  ]), # Right
  #   @grid.has_key?([x+1, y+1]), # Bottom Right
  #   @grid.has_key?([x  , y+1]), # Bottom
  #   @grid.has_key?([x-1, y+1]), # Bottom left
  # ].count(true)
  def countNeighbours(x, y)
    count = 0


    if x - 1 > 0
      count += 1 if @matrix[y][x - 1][0] == '██'
    end
    count += 1 if @matrix[y - 1][x - 1][0] == '██'
    count += 1 if @matrix[y - 1][x][0] == '██'
    if x + 1 >
    count += 1 if @matrix[y - 1][x + 1][0] == '██'
    count += 1 if @matrix[y][x + 1][0] == '██'
    count += 1 if @matrix[y + 1][x + 1][0] == '██'
    count += 1 if @matrix[y + 1][x][0] == '██'
    count += 1 if @matrix[y + 1][x - 1][0] == '██'

    count
  end

  def nextGeneration
    for y in 0...@heigth
      for x in 0...@width
        print "#{x}\n#{y}"
        @matrix[y][x][1] = '░░' if countNeighbours(x, y) < 2
        @matrix[y][x][1] = '░░' if countNeighbours(x, y) > 3
        @matrix[y][x][1] = '██' if countNeighbours(x, y) == 2
        @matrix[y][x][1] = '██' if countNeighbours(x, y) == 3
      end
    end
  end

  def show
    @matrix.each do |i|
      print i
      print "\n"
    end
  end
end

g = Game.new(5, 5)

a = [
  [2, 2],
  [2, 3],
  [2, 4]
]
g.create(x = a)
g.show
g.nextGeneration
g.show
g.countNeighbours(2, 2)
