#!/usr/bin/env ruby

# Contains close nums
#
# Inputs
#   nums: an array of integers
#   k: an integer
#
# Output: Boolean
#   Returns true if two of the same value appear within k slots
#   of each other.

def contains_close_nums(nums, k)
  return false if nums.size < 2

  loc = {} # a hash mapping numbers to the index it was last found at
  nums.each_with_index do |num, i|
    found_at = loc[num]
    loc[num] = i
    return true if !found_at.nil? && i - found_at <= k
  end

  false
end

require 'rspec/autorun'

RSpec.describe '#contains_close_nums' do
  let(:k) { 3 }
  let(:nums) { [2, 3, 5, 3, 37, 48, 5, 256, 2] }

  it 'works for example 1' do
    expect(contains_close_nums(nums, k)).to be true
  end

  it 'works for example 2' do
    stream = [2, 4, 5, 3, 37, 48, 5, 256, 2]
    expect(contains_close_nums(stream, 3)).to be false
  end
end
