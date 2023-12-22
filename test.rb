# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'game_of_life' # assuming your class is defined in game_of_life.rb

# Test for our class; Cell checked [1, 1]
class TestGameOfLife < Minitest::Test
  def test_underpopulation
    # Set up a cell with fewer than two neighbours
    t = [[0, 0], [1, 1]]
    g = GameOfLife.new(3, 3, '1', '0')
    g.create(t)
    g.next_generation

    assert_equal '0', g.matrix[1][1][g.flag]
  end

  def test_overcrowding
    # Set up a cell with more than three neighbours
    t = [[0, 0], [0, 2], [1, 1], [2, 0], [2, 2]]
    g = GameOfLife.new(3, 3, '1', '0')
    g.create(t)
    g.next_generation

    assert_equal '0', g.matrix[1][1][g.flag]
  end

  def test_survival
    # Set up a cell with two or three neighbours
    t = [[0, 0], [0, 2], [1, 1]]
    g = GameOfLife.new(3, 3, '1', '0')
    g.create(t)
    g.next_generation

    assert_equal '1', g.matrix[1][1][g.flag]
  end

  def test_reproduction
    # Set up a dead cell with exactly three neighbours
    t = [[0, 0], [0, 2], [2, 0]]
    g = GameOfLife.new(3, 3, '1', '0')
    g.create(t)
    g.next_generation

    assert_equal '1', g.matrix[1][1][g.flag]
  end
end

# g = GameOfLife.new(16, 16, '1', '0')

# a = [
#   [2, 2],
#   [2, 3]
# ]

# b = [
#   [2, 2],
#   [2, 3],
#   [2, 4],
#   [1, 4],
#   [0, 3]
# ]

# c = [
#   [2, 2],
#   [2, 3],
#   [2, 4],
#   [3, 2],
#   [3, 4],
#   [4, 2],
#   [4, 3],
#   [4, 4]
# ]

# move structure to the center

# c.each do |i|
#   i[0] += 1
#   i[1] += 1
# end

# g.create(c)

# g.bucle
