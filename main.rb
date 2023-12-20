# frozen_string_literal: true

class Game
  attr_accessor :width, :height, :flag

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
    @flag = 0
  end

  def create(x, y = nil)
    @matrix[y][x] = '██' unless y.nil?
    return unless x.is_a?(Array)

    x.each do |i|
      @matrix[i[1]][i[0]][0] = '██'
    end
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
        if nx >= 0 && nx < @matrix[0].length && ny >= 0 && ny < @matrix.length && (@matrix[ny][nx][@flag] == '██')
          count += 1
        end
      end
    end

    count
  end

  def next_generation
    for y in 0...@heigth
      for x in 0...@width

        # avoid overlaying
        @matrix[y][x][@flag.abs - 1] = '░░' if @matrix[y][x][@flag] == '░░'

        if @matrix[y][x][@flag] == '██'
          @matrix[y][x][@flag.abs - 1] = '░░' if count_neighbours(x, y) < 2
          @matrix[y][x][@flag.abs - 1] = '░░' if count_neighbours(x, y) > 3
          @matrix[y][x][@flag.abs - 1] = '██' if count_neighbours(x, y) == 2 || count_neighbours(x, y) == 3
        elsif count_neighbours(x, y) == 3

          @matrix[y][x][@flag.abs - 1] = '██'
        end
      end
    end

    @flag = @flag == 1 ? 0 : 1
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
      show
      next_generation
      sleep(1)
      system('clear')
    end
  end
end

g = Game.new(10, 10)

a = [
  [2, 2],
  [2, 3],
  [2, 4]
]

b = [
  [2, 2],
  [2, 3],
  [2, 4],
  [1, 4],
  [0, 3]
]

c = [
  [2, 2],
  [2, 3],
  [2, 4],
  [3, 2],
  [3, 4],
  [4, 2],
  [4, 3],
  [4, 4]
]

# move structure to the center

c.each do |i|
  i[0] += 1
  i[1] += 1
end

g.create(c)

g.bucle
