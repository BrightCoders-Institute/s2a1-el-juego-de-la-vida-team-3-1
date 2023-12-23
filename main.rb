# frozen_string_literal: false

require_relative './game/game_of_life'

# g = GameOfLife.new(16, 16, '1', '0')

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
t = [[0, 0], [0, 2], [1, 1]]
u = [[0, 0], [0, 2], [2, 0]]
# move c structure to the center

c.each do |i|
  i[0] += 1
  i[1] += 1
end
b.each do |i|
  i[0] += 1
  i[1] += 1
end

g = GameOfLife.new(10, 10)
g.create_cells(c)

g.start
