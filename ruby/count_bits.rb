# frozen_string_literal: true

=begin
# Count bits
Source: https://leetcode.com/problems/number-of-1-bits/

## Description
Write a function that takes an unsigned integer and return the number of '1'
bits it has (also known as the Hamming weight).

Example 1:

Input: 00000000000000000000000000001011
Output: 3
Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.

Example 2:

Input: 00000000000000000000000010000000
Output: 1
Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.

Example 3:

Input: 11111111111111111111111111111101
Output: 31
Explanation: The input binary string 11111111111111111111111111111101 has a total of thirty one '1' bits.

Note:

Note that in some languages such as Java, there is no unsigned integer type. In
this case, the input will be given as signed integer type and should not affect
your implementation, as the internal binary representation of the integer is the
same whether it is signed or unsigned.

In Java, the compiler represents the signed integers using 2's complement
notation. Therefore, in Example 3 above the input represents the signed integer
-3.

=end

require 'rspec/autorun'

# @param {Integer} n, a positive integer
# @return {Integer}
def hamming_weight(n)
  count = 0
  while n.positive?
    n &= n - 1
    count += 1
  end
  count
end

# @param {Integer} n, a positive integer
# @return {Integer}
def hamming_weight_naive(n)
  count = 0
  while n.positive?
    count += n & 1
    n = n >> 1
  end
  count
end


RSpec.describe '#hamming_weight' do
  describe '#hamming_weight' do
    it 'solves example 1' do
      expect(hamming_weight('00000000000000000000000000001011'.to_i(2))).to eq(3)
    end

    it 'solves example 2' do
      expect(hamming_weight('00000000000000000000000010000000'.to_i(2))).to eq(1)
    end

    it 'solves example 3' do
      expect(hamming_weight('11111111111111111111111111111101'.to_i(2))).to eq(31)
    end
  end
end
