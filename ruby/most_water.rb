# frozen_string_literal: true

=begin
# Container with most water
Source: https://leetcode.com/problems/container-with-most-water/

## Description
Given n non-negative integers a1, a2, ..., an , where each represents a point at
coordinate (i, ai). n vertical lines are drawn such that the two endpoints of
line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis
forms a container, such that the container contains the most water.

Note: You may not slant the container and n is at least 2.

8      X                   X
7      X                   X       X
6      X   X               X       X
5      X   X       X       X       X
4      X   X       X   X   X       X
3      X   X       X   X   X       X
2      X   X       X   X   X   X   X
1      X   X   X   X   X   X   X   X
0  X   X   X   X   X   X   X   X   X
---+---+---+---+---+---+---+---+---+---+---+---+
[Figure]

The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this
case, the max area of water (blue section) the container can contain is 49.

Example:

Input: [1,8,6,2,5,4,8,3,7]
Output: 49

=end

require 'rspec/autorun'
require 'set'

# @param {Integer[]} height
# @return {Integer}
def max_area_naive(height)
  max = 0
  (0..(height.size - 2)).each do |i|
    ((i + 1)..(height.size - 1)).each do |j|
      area = [height[i], height[j]].min * (j - i)
      max = [max, area].max
    end
  end
  max
end

# @param {Integer[]} height
# @return {Integer}
def max_area(height)
  max = 0
  left = 0
  right = height.size - 1
  while left < right
    area = [height[left], height[right]].min * (right - left)
    max = [max, area].max
    if height[left] < height[right]
      left += 1
    else
      right -= 1
    end
  end
  max
end

RSpec.describe '#max_area' do
  describe '#max_area' do
    it 'solves example 1' do
      expect(max_area([1, 8, 6, 2, 5, 4, 8, 3, 7])).to eq(49)
    end

    it 'solves example 2' do
      expect(max_area([1, 1, 1, 1, 1, 1, 1, 1, 1])).to eq(8)
    end
  end
end
