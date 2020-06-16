# https://leetcode.com/problems/add-two-numbers/
require 'rspec/autorun'

# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  min_buy = prices[0]
  max_profit = 0
  prices.each do |p|
    if (p < min_buy)
      min_buy = p
    else
      # max_profit = [max_profit, p - min_buy].max
      if p - min_buy > max_profit
        max_profit = p - min_buy
      end
    end
  end
  max_profit
end

RSpec.describe '#max_profit' do
  describe '#max_profit' do
    it 'works' do
      expect(max_profit([7,1,5,3,6,4])).to eq(5)
    end
  end
end

