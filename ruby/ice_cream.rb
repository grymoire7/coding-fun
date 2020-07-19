# frozen_string_literal: true

=begin
# Ice Cream Parlor

## Description
Source: https://www.hackerrank.com/challenges/icecream-parlor/problem

Sunny and Johnny like to pool their money and go to the ice cream parlor. Johnny
never buys the same flavor that Sunny does. The only other rule they have is
that they spend all of their money.

Given a list of prices for the flavors of ice cream, select the two that will
cost all of the money they have.

For example, they have m = 6 to spend and there are flavors costing cost =
[1, 3, 4, 5, 6]. The two flavors costing 1 and 5 meet the criteria. Using 1-based
indexing, they are at indices 1 and 4.

Function Description

Complete the icecreamParlor function in the editor below. It should return an
array containing the indices of the prices of the two flavors they buy, sorted
ascending.

icecreamParlor has the following parameter(s):

* m: an integer denoting the amount of money they have to spend
* cost: an integer array denoting the cost of each flavor of ice cream

There will always be a unique solution.

Output Format

For each test case, print two space-separated integers denoting the indices of
the two flavors purchased, in ascending order.

Sample Input

2
4
5
1 4 5 3 2
4
4
2 2 4 3

Sample Output

1 4
1 2

Explanation

Sunny and Johnny make the following two trips to the parlor:

The first time, they pool together m = 4 dollars. Of the five flavors available
that day, flavors 1 and 4 have a total cost of 1 + 3 = 4.

The second time, they pool together m = 4 dollars. Of the four flavors
available that day, flavors 1 and 2 have a total cost of 2 + 2 = 4.

=end

require 'rspec/autorun'

# Complete the icecreamParlor function below.
# @param Integer m           # total money
# @param Array{Integer} arr  # array of costs
def ice_cream_parlor(m, arr)
  used = {}

  (0..arr.size).each do |i|
    next if used.has_key?(arr[i]) # optional
    used[arr[i]] = true           # speed-up

    ((i+1)...arr.size).each do |j|
      return [i + 1, j + 1] if arr[i] + arr[j] == m
    end
  end

  nil
end

RSpec.describe '#ice_cream_parlor' do
  describe '#ice_cream_parlor' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(ice_cream_parlor(4, [1, 4, 5, 3, 2])).to eq([1, 4])
    end

    it 'solves example 2' do
      expect(ice_cream_parlor(4, [2, 2, 4, 3])).to eq([1, 2])
    end
  end
end
