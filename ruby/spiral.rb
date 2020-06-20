# frozen_string_literal: true

=begin
# Spiral matrix

## Description

Find the pattern and complete the function:
  int[][] spiral(int n);
where n is the size of the 2D array.

## Sample Result
input = 3
123
894
765

input = 4
01 02 03 04
12 13 14 05
11 16 15 06
10 09 08 07

input = 8
1 2 3 4 5 6 7 8
28 29 30 31 32 33 34 9
27 48 49 50 51 52 35 10
26 47 60 61 62 53 36 11
25 46 59 64 63 54 37 12
24 45 58 57 56 55 38 13
23 44 43 42 41 40 39 14
22 21 20 19 18 17 16 15

=end

require 'rspec/autorun'

# @param {Integer} n
# @return Integer[][]
def spiral(n)
  return [[]] if n.nil? || !n.positive?

  r, c, dir = 0, 0, 0
  dir_col = [1, 0, -1,  0]
  dir_row = [0, 1,  0, -1]

  matrix = Array.new(n) { Array.new(n, 0) }
  (1..n*n).each do |val|
    matrix[r][c] = val

    unless valid?(matrix, r + dir_row[dir], c + dir_col[dir])
      dir = (dir + 1) % 4
    end

    r += dir_row[dir]
    c += dir_col[dir]
  end

  matrix
end

def valid?(matrix, r, c)
  in_range = r.between?(0, matrix.size - 1) && c.between?(0, matrix.size - 1)
  return false unless in_range
  return false unless matrix[r][c].zero?
  true
end

RSpec.describe '#spiral' do
  describe '#spiral' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(spiral(3)).to eq([[1, 2, 3], [8, 9, 4], [7, 6, 5]])
    end

    it 'handles empty array' do
      expect(spiral(nil)).to eq([[]])
    end
  end
end
