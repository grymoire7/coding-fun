# frozen_string_literal: true

=begin
# House Robber

Source: https://leetcode.com/problems/house-robber/

## Description
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.


### Example 1:

Input: nums = [1, 2, 3, 1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.

### Example 2:

Input: nums = [2, 7, 9, 3, 1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5
(money = 1). Total amount you can rob = 2 + 9 + 1 = 12.



Constraints:
  0 <= nums.length <= 100
  0 <= nums[i] <= 400

=end

require 'rspec/autorun'

# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  return 0 if nums.nil? || nums.empty?
  return nums[0] if nums.size == 1

  dp = Array.new(nums.size + 1, 0)

  # dp[n] = f(dp[n-1], dp[n-2]) = [dp[n-1], dp[n-2] + nums[n]].max
  (1..(nums.size)).each do |i|
    dp[i] = [dp[i - 1], (dp[i - 2] || 0) + nums[i - 1]].max
  end

  dp[nums.size]
end

RSpec.describe '#rob' do
  describe '#rob' do
    it 'solves example 1' do
      expect(rob([1, 2, 3, 1])).to eq(4)
    end

    it 'solves example 2' do
      expect(rob([2, 7, 9, 3, 1])).to eq(12)
    end

    it 'solves example 3' do
      expect(rob([8])).to eq(8)
    end

    it 'handles empty array' do
      expect(rob([])).to eq(0)
    end
  end
end
