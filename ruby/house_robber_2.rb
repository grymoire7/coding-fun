# frozen_string_literal: true

=begin
# House Robber II

Source: https://leetcode.com/problems/house-robber-ii/

## Description
You are a professional robber planning to rob houses along a street. Each house
has a certain amount of money stashed. All houses at this place are arranged in
a circle. That means the first house is the neighbor of the last one. Meanwhile,
adjacent houses have security system connected and it will automatically contact
the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each
house, determine the maximum amount of money you can rob tonight without
alerting the police.

### Example 1:

Input: [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money =
2), because they are adjacent houses.

### Example 2:

Input: [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3). Total
amount you can rob = 1 + 3 = 4.

=end

require 'rspec/autorun'

# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  return 0 if nums.nil? || nums.empty?
  return nums[0] if nums.size == 1

  max1 = rob_helper(nums[0..-2])
  max2 = rob_helper(nums[1..-1])
  [max1, max2].max
end

# @param {Integer[]} nums
# @return {Integer}
def rob_helper(nums)
  return 0 if nums.nil? || nums.empty?
  return nums[0] if nums.size == 1

  dp = Array.new(nums.size + 1, 0)

  (1..(nums.size)).each do |i|
    dp[i] = [dp[i-1], (dp[i-2] || 0) + nums[i - 1]].max
  end

  dp[nums.size]
end


RSpec.describe '#rob' do
  describe '#rob' do
    it 'solves example 0' do
      expect(rob([2, 3, 2])).to eq(3)
    end

    it 'solves example 1' do
      expect(rob([1, 2, 3, 1])).to eq(4)
    end

    it 'solves example 2' do
      expect(rob([2, 7, 9, 3, 1])).to eq(11)
    end

    it 'solves example 3' do
      expect(rob([8])).to eq(8)
    end

    it 'handles empty array' do
      expect(rob([])).to eq(0)
    end
  end
end
