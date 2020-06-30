# frozen_string_literal: true

=begin
# Rearrange Array

Source: https://www.geeksforgeeks.org/rearrange-given-array-place/

## Description
Given an array arr[] of size n where every element is in range from 0 to n-1.
Rearrange the given array so that arr[i] becomes arr[arr[i]]. This should be
done with O(1) extra space.

Examples:

Input: arr[]  = {3, 2, 0, 1}
Output: arr[] = {1, 0, 3, 2}
Explanation:

In the given array
arr[arr[0]] is 1 so arr[0] in output array is 1
arr[arr[1]] is 0 so arr[1] in output array is 0
arr[arr[2]] is 3 so arr[2] in output array is 3
arr[arr[3]] is 2 so arr[3] in output array is 2

Input: arr[] = {4, 0, 2, 1, 3}
Output: arr[] = {3, 4, 2, 0, 1}

Explanation:
arr[arr[0]] is 3 so arr[0] in output array is 3
arr[arr[1]] is 4 so arr[1] in output array is 4
arr[arr[2]] is 2 so arr[2] in output array is 2
arr[arr[3]] is 0 so arr[3] in output array is 0
arr[arr[4]] is 1 so arr[4] in output array is 1

Input: arr[] = {0, 1, 2, 3}
Output: arr[] = {0, 1, 2, 3}

Explanation:
arr[arr[0]] is 0 so arr[0] in output array is 0
arr[arr[1]] is 1 so arr[1] in output array is 1
arr[arr[2]] is 2 so arr[2] in output array is 2
arr[arr[3]] is 3 so arr[3] in output array is 3

If the extra space condition is removed, the question becomes very easy. The
main part of the question is to do it without extra space. We strongly recommend
that you click here and practice it, before moving on to the solution.

The credit for following solution goes to Ganesh Ram Sundaram.

Approach: The array elements of the given array lies from 0 to n-1. Now an array
element is needed that can store two different values at the same time. To
achieve this increment every element at ith index is incremented by (arr[arr[i]]
% n)*n.After the increment operation of first step, every element holds both old
values and new values. Old value can be obtained by arr[i]%n and a new value can
be obtained by arr[i]/n.

How this can be achieved?
Let's assume an element is a and another element is b, both the elements are
less than n. So if an element a is incremented by b*n. So the element becomes a
+ b*n so when a + b*n is divided by n then the value is b and a + b*n % n is a.

Algorithm:

    1. Traverse the array from start to end.
    2. For every index increment the element by array[array[index] % n]. To get
       the ith element find the modulo with n, i.e array[index]%n. Again Travsese
       the array from start to end
    3. Print the ith element after dividing the ith element by n, i.e. array[i]/n.

=end

require 'rspec/autorun'

# @param {Array{Integer}} arr
# @return nil
def rearrange(arr)
  return if arr.nil? || arr.empty?

  n = arr.size

  (0...n).each do |i|
    arr[i] += (arr[arr[i]] % n) * n
  end

  (0...n).each do |i|
    arr[i] = arr[i] / n
  end
end

RSpec.describe '#rearrange' do
  describe '#rearrange' do
    it 'solves example 1' do
      arr = [3, 2, 0, 1]
      ans = [1, 0, 3, 2]
      rearrange(arr)
      expect(arr).to eq(ans)
    end

    it 'solves example 2' do
      arr = [4, 0, 2, 1, 3]
      ans = [3, 4, 2, 0, 1]
      rearrange(arr)
      expect(arr).to eq(ans)
    end

    it 'solves example 3' do
      arr = [0, 1, 2, 3]
      ans = [0, 1, 2, 3]
      rearrange(arr)
      expect(arr).to eq(ans)
    end
  end
end
