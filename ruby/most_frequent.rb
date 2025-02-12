# frozen_string_literal: true

# Given an array, find the most frequent element in it. If there are multiple
# elements that appear most number of times, print any one of them.
#
# Examples:
# Input: arr[] = {1, 3, 1, 3, 2, 1}
# Output: 1
# Input: arr[] = {10, 20, 10, 20, 30, 20, 20}
# Output: 20

require 'rspec/autorun'

def most_frequent_element(arr)
  # nests_loops_method(arr)  # O(n^2) time complexity
  # sort_and_count(arr)      # O(n log n) time complexity
  sort_and_count_each(arr) # O(n log n) time complexity
  # hash_table_method(arr)   # O(n) time complexity
  # tally_method(arr)      # O(n) time complexity (uses hash)
  # string_method(arr)     # O(n log n) time complexity (uses sort)
  # voting_algorithm(arr)  # O(n) time complexity (but doesn't work for all cases)
end

# Use group_by method; O(n) time complexity like hash_table_method
def tally_method(arr) = arr.tally.max_by { |_, v| v }.first

# Hash table method; O(n) time complexity;  O(n) space complexity
def hash_table_method(arr)
  hash = Hash.new(0)
  max_count = 0
  max_item = 0

  arr.each do |item|
    hash[item] += 1

    if hash[item] > max_count
      max_count = hash[item]
      max_item = item
    end
  end

  max_item
end

# Sort and count group elements
# O(n log n) time complexity
def sort_and_count_each(arr)
  arr.sort!
  max_count = 0
  max_item = 0

  count = 1
  arr.each_cons(2) do |item, next_item|
    if item == next_item
      count += 1
    else
      if count > max_count
        max_count = count
        max_item = item
      end
      count = 1
    end
  end

  max_item
end

# Sort and count group elements
# O(n log n) time complexity
def sort_and_count(arr)
  arr.sort!
  max_count = 0
  max_item = 0

  count = 1
  arr.each_with_index do |item, index|
    if index < arr.length - 1 && item == arr[index + 1]
      count += 1
    else
      if count > max_count
        max_count = count
        max_item = item
      end
      count = 1
    end
  end

  max_item
end

# Use sort and string#gsub
def string_method(arr) = arr.sort.join.gsub(/(.)\1*/).max_by(&:length)[0].to_i

# O(n^2) time complexity
def nests_loops_method(arr)
  max_count = 0
  max_item = 0

  arr.each do |item|
    count = 0

    arr.each do |inner_item|
      count += 1 if item == inner_item
    end

    if count > max_count
      max_count = count
      max_item = item
    end
  end

  max_item
end

# voting algorithm, single pass
# O(n) time complexity
def voting_algorithm(arr)
  # First pass: find candidate
  count = 0
  candidate = 0

  arr.each do |item|
    if count.zero?
      candidate = item
      count = 1
    elsif item == candidate
      count += 1
    else
      count -= 1
    end
  end

  puts "candidate: #{candidate}"

  # Second pass: verify candidate occurs more than n/2 times
  occurrences = arr.count(candidate)

  occurrences > arr.length / 2 ? candidate : 0
end

RSpec.describe '#most_frequent_element' do
  describe '#most_frequent_element' do
    let(:arr1) { [1, 3, 1, 3, 2, 1] }
    let(:arr2) { [3, 5, 5, 3, 1, 3, 2, 1] }
    let(:arr3) { [5, 3, 5, 3, 5, 3, 5] } # 5 is the majority element
    let(:arr4) { %w[c abc abc abc ab bc ac] }

    it 'solves example 1' do
      expect(most_frequent_element(arr1)).to eq(1)
    end

    it 'solves example 2' do
      expect(most_frequent_element(arr2)).to eq(3)
    end

    it 'solves example 3 with voting' do
      expect(voting_algorithm(arr3)).to eq(5)
    end

    it 'solves example 4' do
      expect(most_frequent_element(arr4)).to eq('abc')
    end
  end
end
