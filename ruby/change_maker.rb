
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
