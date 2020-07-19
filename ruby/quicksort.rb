# frozen_string_literal: true

=begin
# Quicksort

## Description
Source: https://www.hackerrank.com/challenges/quicksort2/problem

Sort using quicksort.

=end

require 'rspec/autorun'

def quicksort(arr, first = 0, last = nil)
  last = arr.size - 1 if last.nil?

  if first < last
    p_index = partition(arr, first, last)
    quicksort(arr, first, p_index - 1)
    quicksort(arr, p_index + 1, last)
  end

  arr
end

def partition(arr, first, last)
  pivot = arr[last]
  p_index = first
  puts "p: pivot = #{pivot}, first = #{first}, last = #{last}"
  puts "p: arr = #{arr}"

  for i in (first...last)
    if arr[i] < pivot
      arr[i], arr[p_index] = arr[p_index], arr[i]
      p_index += 1
    end
  end

  arr[last] = arr[p_index]
  arr[p_index] = pivot

  puts "p: pivoted on #{p_index}, arr = #{arr}"
  p_index
end

RSpec.describe '#quicksort' do
  describe '#quicksort' do

    it 'solves example 1' do
      arr = [3, 4, 1, 5, 7, 1, 4]
      arr_sorted = arr.sort
      quicksort(arr)
      expect(arr).to eq(arr_sorted)
    end

    it 'solves example 2' do
      arr = [5, 8, 1, 3, 7, 9, 2]
      arr_sorted = arr.sort
      quicksort(arr)
      expect(arr).to eq(arr_sorted)
    end
  end
end
