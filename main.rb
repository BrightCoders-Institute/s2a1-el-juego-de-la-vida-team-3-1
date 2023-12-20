# frozen_string_literal: true

# puts "░░ ░░ ░░\n░░ ██ ░░\n██ ░░ ░░"
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
        next if dx == 0 && dy == 0  # Skip the cell itself

        nx, ny = x + dx, y + dy

        # Check if the neighbor is within the grid
        if nx >= 0 && nx < @matrix[0].length && ny >= 0 && ny < @matrix.length
          count += 1 if @matrix[ny][nx][@flag] == '██'
        end
      end
    end

    count
  end

  def next_generation
    for y in 0...@heigth
      for x in 0...@width
        if @matrix[y][x][0] == '██'
          @matrix[y][x][@flag.abs()-1] = '░░' if count_neighbours(x, y) < 2
          @matrix[y][x][@flag.abs()-1] = '░░' if count_neighbours(x, y) > 3
          @matrix[y][x][@flag.abs()-1] = '██' if count_neighbours(x, y) == 2
        else
          @matrix[y][x][@flag.abs()-1] = '██' if count_neighbours(x, y) == 3
        end
      end
    end
    @flag == 1 ? @flag = 0 : @flag = 1
  end

  def show
    @matrix.each do |i|
      i.each do |j|
        print j[@flag]
      end
      # print i
      print "\n"
    end
  end

  def bucle
    loop do
      next_generation
      puts ''
      show
      sleep(1)
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
# c = [
  #   [2, 2],
  #   [2, 3],
  #   [2, 4],
  #   [4, 2],
  #   [4, 3],
  #   [4, 4]
  # ]
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


  g.create(x = c)
  g.show
  g.bucle
  # g.show
  # puts ""

  # for i in 1..4
  #   g.next_generation
  # end

  # g.next_generation
  # g.flag
  # puts ""
  # g.show
  # # puts ""
  # g.next_generation
  # g.flag
  # puts ''
  # g.show
  # # g.count_neighbours(2, 2)
  # g.next_generation
  # g.flag
  # puts ''
  # g.show



  # LAST VERSION OF count_neighbours METHOD
  # def count_neighbours(x, y)
  #   count = 0

  #   # Check left neighbor
  #   if x - 1 >= 0
  #     count += 1 if @matrix[y][x - 1][@flag] == '██'
  #   end

  #   # Check top-left neighbor
  #   if x - 1 >= 0 && y - 1 >= 0
  #     count += 1 if @matrix[y - 1][x - 1][@flag] == '██'
  #   end

  #   # Check top neighbor
  #   if y - 1 >= 0
  #     count += 1 if @matrix[y - 1][x][@flag] == '██'
  #   end

  #   # Check top-right neighbor
  #   if x + 1 < @matrix[0].length && y - 1 >= 0
  #     count += 1 if @matrix[y - 1][x + 1][@flag] == '██'
  #   end

  #   # Check right neighbor
  #   if x + 1 < @matrix[0].length
  #     count += 1 if @matrix[y][x + 1][@flag] == '██'
  #   end

  #   # Check bottom-right neighbor
  #   if x + 1 < @matrix[0].length && y + 1 < @matrix.length
  #     count += 1 if @matrix[y + 1][x + 1][@flag] == '██'
  #   end

  #   # Check bottom neighbor
  #   if y + 1 < @matrix.length
  #     count += 1 if @matrix[y + 1][x][@flag] == '██'
  #   end

  #   # Check bottom-left neighbor
  #   if x - 1 >= 0 && y + 1 < @matrix.length
  #     count += 1 if @matrix[y + 1][x - 1][@flag] == '██'
  #   end

  #   count
  # end
