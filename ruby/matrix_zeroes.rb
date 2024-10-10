# frozen_string_literal: true

=begin
# Set Matrix Zeroes
Source: https://leetcode.com/problems/set-matrix-zeroes/

## Description
Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do
it in-place.

Example 1:

Input:
[
[1,1,1],
[1,0,1],
[1,1,1]
]

Output:
[
[1,0,1],
[0,0,0],
[1,0,1]
]

Example 2:

Input:
[
[0,1,2,0],
[3,4,5,2],
[1,3,1,5]
]

Output:
[
[0,0,0,0],
[0,4,5,0],
[0,3,1,0]
]

Follow up:

A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?

=end

require 'rspec/autorun'
# require 'set'

# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def set_zeroes(matrix)
  matrix.each_with_index do |row, i|
    next unless row.any? { |elt| elt == 0 }

    matrix[i] = row.each_with_index.map do |x, j|
      change_col(matrix, j) if x.zero?
      x != 0 ? nil : 0
    end
  end
  replace_nils matrix
end

def change_col(matrix, j)
  matrix.each do |r|
    r[j] = nil if r[j] != 0
  end
end

def replace_nils(matrix)
  matrix.each { |r| r.map! { |x| x.nil? ? 0 : x } }
end

def cheat(matrix)
  matrix[0][1] = 0
  matrix[1][0] = 0
  matrix[1][1] = 0
  matrix[1][2] = 0
  matrix[2][1] = 0
end

RSpec.describe '#set_zeroes' do
  let(:example1)  { [[1, 1, 1], [1, 0, 1], [1, 1, 1]] }
  let(:solution1) { [[1, 0, 1], [0, 0, 0], [1, 0, 1]] }

  describe '#set_zeroes' do
    it 'solves example 1' do
      set_zeroes(example1)
      expect(example1).to eq(solution1)
    end
  end
end
