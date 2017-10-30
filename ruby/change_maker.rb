#!/usr/bin/env ruby

# Changemaker
#
class ChangeMaker
  COINS = [25, 10, 5, 1].freeze

  # change_for takes an amount in cents and return the least number of coins
  # in from COINS that will sum to the given amount.
  #
  # @param   amt  amount in cents
  # @returns      array of coins that total amt
  def self.change_for(amt)
    coins = COINS.dup.sort.reverse
    coins.map do |coin|
      num_coins = amt / coin
      amt %= coin
      # p "coin: #{coin}, num: #{num_coins}, amt: #{amt}"
      Array.new(num_coins, coin)
    end.flatten
  end
end

RSpec.describe ChangeMaker do
  it 'is greedy' do
    expect(ChangeMaker.change_for(100)).to eq([25, 25, 25, 25])
    expect(ChangeMaker.change_for(38)).to eq([25, 10, 1, 1, 1])
  end

  it 'is efficient' do
    expect(ChangeMaker.change_for(12)).to eq([10, 1, 1])
    expect(ChangeMaker.change_for(17)).to eq([10, 5, 1, 1])
  end
end
