# frozen_string_literal: true

=begin
# Unique paths in a grid

Source: https://www.interviewbit.com/problems/unique-paths-in-a-grid/

## Description
Given a grid of size m * n, lets assume you are starting at (1,1) and your goal
is to reach (m,n). At any instance, if you are on (x,y), you can either go to
(x, y + 1) or (x + 1, y).

Now consider if some obstacles are added to the grids. How many unique paths
would there be? An obstacle and empty space is marked as 1 and 0 respectively in
the grid.

Example :
There is one obstacle in the middle of a 3x3 grid as illustrated below.

[
  [0, 0, 0],
  [0, 1, 0],
  [0, 0, 0]
]

The total number of unique paths is 2.
=end

require 'rspec/autorun'

# @param {Integer[][]} matrix
# @return {Integer}
def unique_paths(matrix)
  return 0 if matrix.nil? || matrix.empty?

  m = matrix.size
  n = matrix[0].size
  paths = Array.new(m) { Array.new(n, 0) }
  paths[0][0] = 1 if matrix[0][0].zero?

  # init first column
  (1...m).each do |i|
    paths[i][0] = paths[i - 1][0] if matrix[i][0].zero?
  end

  # init first row
  (1...n).each do |j|
    paths[0][j] = paths[0][j - 1] if matrix[0][j].zero?
  end

  (1...m).each do |i|
    (1...n).each do |j|
      paths[i][j] = paths[i][j - 1] + paths[i - 1][j] if matrix[i][j].zero?
    end
  end

  paths[-1][-1]
end


RSpec.describe '#unique_paths' do
  describe '#unique_paths' do
    it 'solves example 1' do
      expect(unique_paths([[0, 0, 0], [0, 1, 0], [0, 0, 0]])).to eq(2)
    end

    it 'solves 1x1 with no obstacles' do
      expect(unique_paths([[0]])).to eq(1)
    end

    it 'solves 1x1 with an obstacle' do
      expect(unique_paths([[1]])).to eq(0)
    end

    it 'handles empty array' do
      expect(unique_paths([])).to eq(0)
    end
  end
end
