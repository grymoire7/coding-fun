#!/bin/env ruby

require 'rspec/autorun'

# Given an array of integers, return the smallest positive integer (greater
# than 0) that does not occur in the array.
# 
# For example, given [1, 3, 6, 4, 1, 2], the function should return 5.
# 
# Given [1, 2, 3, 4], the function should return 5.
# 
# Given [−2, −5], the function should return 1.
# 
# Write an efficient algorithm given:
# 
# - Array length is an integer within the range [1..100,000];
# - Each element of the array is an integer within the range [−1,000,000..1,000,000].

def solution(a)
  seen = {}

  a.each do |num|
    seen[num] = true if num > 0
  end

  smallest = 1
  smallest += 1 while seen[smallest]

  smallest
end

RSpec.describe '#solution' do
  it 'solves example 1' do
    expect(solution([1, 3, 6, 4, 1, 2])).to eq(5)
  end

  it 'solves example 2' do
    expect(solution([1, 2, 3])).to eq(4)
  end

  it 'solves example 3' do
    expect(solution([-1, -3])).to eq(1)
  end
end
