=begin
# Best time to buy and sell stock III
## Description
Source: https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/
Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most two transactions.

Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

### Example 1:

Input: [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
             Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.

### Example 2:

Input: [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
             Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
             engaging multiple transactions at the same time. You must sell before buying again.

### Example 3:

Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.


## Approach
Divide and conquer. Partition the prices area by i and find the max profit before and after i.
Then choose i for max profit max(max_profit, left[i] + right[i]).
=end

require 'rspec/autorun'

# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  return if prices.nil? || prices.size < 2

  left_max = Array.new(prices.size, 0)
  right_max = Array.new(prices.size, 0)

  min_buy = prices[0]
  1.upto(prices.size - 1) do |i|
    min_buy = [min_buy, prices[i]].min
    left_max[i] = [left_max[i - 1], prices[i] - min_buy].max
  end

  max = prices.last
  (prices.size - 2).downto(0) do |i|
    max = [max, prices[i]].max
    right_max[i] = [right_max[i + 1], max - prices[i]].max
  end
  puts "prices: #{prices}"
  puts "left_max: #{left_max}"
  puts "right_max: #{right_max}"

  [left_max, right_max].transpose.map { |x| x.reduce(:+) }.max
end

RSpec.describe '#max_profit' do
  describe '#max_profit' do
    it 'solves example 1' do
      expect(max_profit([3,3,5,0,0,3,1,4])).to eq(6)
    end
    it 'solves example 2' do
      expect(max_profit([1,2,3,4,5])).to eq(4)
    end
    it 'solves example 3' do
      expect(max_profit([7,6,4,3,1])).to eq(0)
    end
  end
end

