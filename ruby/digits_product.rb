# frozen_string_literal: true

# Given an integer product, find the smallest positive (i.e. greater
# than 0) integer the product of whose digits is equal to product.
# If there is no such integer, return -1 instead.
#
# Example:
# For product = 12, the output should be
#   digitsProduct(product) = 26;
# For product = 19, the output should be
#   digitsProduct(product) = -1.

def digits_product(product)
  return 10 if product.zero?

  ans = []
  while product > 9
    9.downto(2).each do |i|
      if (product % i).zero?
        ans.unshift i
        product /= i
        break
      end
      return -1 if i == 2
    end
  end
  ans.unshift product
  ans.empty? ? -1 : ans.join.to_i
end

# Test cases
p digits_product(12) => 26
p digits_product(19) => -1
p digits_product(0) => 10
p digits_product(1) => 1
p digits_product(243) => 399
