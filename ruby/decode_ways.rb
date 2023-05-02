# frozen_string_literal: true

=begin
# Decode Ways

Source: https://leetcode.com/problems/decode-ways/

## Description
A message containing letters from A-Z is being encoded to numbers using the
following mapping:

  'A' -> 1
  'B' -> 2
  ...
  'Z' -> 26

Given a non-empty string containing only digits, determine the total number of
ways to decode it.

Example 1:

  Input: "12"
  Output: 2
  Explanation: It could be decoded as "AB" (1 2) or "L" (12).

Example 2:

  Input: "226"
  Output: 3
Explanation: It could be decoded as "BZ" (2 26), "VF" (22 6), or
"BBF" (2 2 6).

=end

require 'rspec/autorun'

# @param {String} s
# @return {Integer}
def num_decodings(s)
  # dp[n] = dp[n-1] + dp[n-2]
  #
  dp = Array.new(s.size + 1, 0)
  dp[0] = 1
  return 0 if s.nil? || s.empty?
  return 0 if s[0] == '0'

  dp[1] = 1

  # s: 2 2 6
  # dp: 1 1 2 3
  # s:  1 3 1
  # dp: 1 1 2 2
  # s:  1 2 0
  # dp: 1 1 2 1

  (1..(s.size - 1)).each do |i|
    c = s[i]
    p = s[i - 1]
    return 0 if c == '0' && (p == '0' || p > '2')

    dp[i + 1] = dp_next(p, c, dp[i], dp[i - 1])
  end

  dp[s.size]
end

def dp_next(p, c, current, last)
  dp_procs = {
    # '0' => proc { current },
    '1' => proc do
             return last if c == '0'

             last + current
           end,
    '2' => proc do
             return last if c == '0'
             return last + current if c <= '6'

             current
           end
  }
  dp_procs.default_proc = proc { |h, k| h[k] = proc { current } }

  dp_procs[p].call
end

RSpec.describe '#num_decodings' do
  describe '#num_decodings' do
    it 'solves example 1' do
      expect(num_decodings('12')).to eq(2)
    end

    it 'solves example 2' do
      expect(num_decodings('226')).to eq(3)
    end

    it 'solves example 3' do
      expect(num_decodings('131')).to eq(2)
    end

    it 'solves example 4' do
      result = num_decodings(
        '4757562545844617494555774581341211511296816786586787755257741178599337186486723247528324612117156948'
      )
      expect(result).to eq(589_824)
    end

    it 'solves example 5' do
      expect(num_decodings('120')).to eq(1)
    end
  end
end
