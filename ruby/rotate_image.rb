# frozen_string_literal: true

=begin
# Rotate Image
Source: https://leetcode.com/problems/rotate-image/

## Description
You are given an n x n 2D matrix representing an image.

Rotate the image by 90 degrees (clockwise).

Note:

You have to rotate the image in-place, which means you have to modify the input
2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Example 1:

Given input matrix =
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]

Example 2:

Given input matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
],

rotate the input matrix in-place such that it becomes:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]

=end

require 'rspec/autorun'

# @param {Integer[][]} matrix
# @return {Void} Do not return anything, modify matrix in-place instead.
def rotate(matrix)
  rings_num = (matrix.size - 1) / 2
  puts "rings_num = #{rings_num}"
  mli = matrix.size - 1 # matrix last index
  0.upto(rings_num) do |r|
    puts "Working on ring #{r}..."
    r.upto(mli - r - 1) do |i|
      swap(matrix, r, i)
    end
  end
end

def swap(matrix, r, i)
  j = matrix.size - 1 - r
  v = matrix.size - 1 - i
  puts "i, j = #{i}, #{j}"
  matrix[r][i], matrix[v][r], matrix[j][v], matrix[i][j] = matrix[v][r], matrix[j][v], matrix[i][j], matrix[r][i]
  puts matrix.inspect
end

def xswap(matrix, r, i)
  j = matrix.size - 1 - r
  v = matrix.size - 1 - i
  puts "i, j = #{i}, #{j}"
  tmp = matrix[r][i]
  matrix[r][i] = matrix[v][r]
  matrix[v][r] = matrix[j][v]
  matrix[j][v] = matrix[i][j]
  matrix[i][j] = tmp
  puts matrix.inspect
end

RSpec.describe '#rotate' do
  let(:image1) {
    [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
  }
  let(:answer1) {
    [
      [7, 4, 1],
      [8, 5, 2],
      [9, 6, 3]
    ]
  }

  let(:image2) {
    [
      [ 5,  1,  9, 11],
      [ 2,  4,  8, 10],
      [13,  3,  6,  7],
      [15, 14, 12, 16]
    ]
  }
  let(:answer2) {
    [
      [15, 13,  2,  5],
      [14,  3,  4,  1],
      [12,  6,  8,  9],
      [16,  7, 10, 11]
    ]
  }

  let(:image3) {
    [
      [1]
    ]
  }
  let(:answer3) {
    [
      [1]
    ]
  }

  let(:image4) {
    [
      [ 1,  2,  3,  4],
      [ 5,  6,  7,  8],
      [ 9, 10, 11, 12],
      [13, 14, 15, 16]
    ]
  }
  let(:answer4) {
    [
      [13,  9,  5,  1],
      [14, 10,  6,  2],
      [15, 11,  7,  3],
      [16, 12,  8,  4]
    ]
  }

  describe '#rotate' do
    it 'solves example 1' do
      rotate(image1)
      expect(image1).to eq(answer1)
    end

    it 'solves example 2' do
      rotate(image2)
      expect(image2).to eq(answer2)
    end

    it 'solves example 3' do
      rotate(image3)
      expect(image3).to eq(answer3)
    end

    it 'solves example 4' do
      rotate(image4)
      expect(image4).to eq(answer4)
    end
  end
end
