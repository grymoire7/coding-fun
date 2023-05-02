# frozen_string_literal: true

=begin
# Square Root

Source: https://www.geeksforgeeks.org/square-root-of-an-integer/

## Description

=end

require 'rspec/autorun'

# @param {Integer} n
# @return n
def floor_sqrt(n)
  return nil if n.nil? || n.negative?
  return n if n.zero? || n == 1

  left = 1
  right = n
  ans = 1

  while left <= right
    mid = (left + right) / 2
    puts "left = #{left}, mid = #{mid}, right = #{right}"

    return mid if mid * mid == n

    if mid * mid < n
      left = mid + 1
      ans = mid
    else
      right = mid - 1
    end
  end

  puts ans
  ans
end

RSpec.describe '#floor_sqrt' do
  describe '#floor_sqrt' do
    it 'solves example 1' do
      expect(floor_sqrt(4)).to eq(2)
    end

    it 'solves example 2' do
      expect(floor_sqrt(11)).to eq(3)
    end

    it 'solves example 3' do
      expect(floor_sqrt(0)).to eq(0)
    end
  end
end
