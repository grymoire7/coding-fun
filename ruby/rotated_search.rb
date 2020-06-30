# frozen_string_literal: true

=begin
# Rotated Array

## Description
Suppose a sorted array A is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

Find the minimum element.

The array will not contain duplicates.

=end

require 'rspec/autorun'

# @param Array{Integer} a  # array in which to search
# @param Integer b         # value to search for
# @return Integer          # index of b, else -1
def find_min(a, b)
  return -1 if a.nil? || a.empty?
  index = 0
  left = 0
  right = a.size - 1

  while (left <= right)
    mid = (left + right) / 2
    return mid if a[mid] == b

    if a[left] < a[mid]
      if  b >= a[left] && b < a[mid]  # b is here
        right = mid - 1
      else
        left = mid + 1
      end
    else
      if  b > a[mid] && b <= a[right]  # b is here
        left = mid + 1
      else
        right = mid - 1
      end
    end
  end

  -1
end

RSpec.describe '#find_min' do
  describe '#find_min' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(find_min([4, 5, 6, 7, 0, 1, 2], 1)).to eq(5)
    end

    it 'solves example 2' do
      expect(find_min([4, 5, 6, 7, 0, 1, 2], 5)).to eq(1)
    end

    it 'handles nil' do
      expect(find_min(nil, 0)).to eq(-1)
    end

    it 'handles empty array' do
      expect(find_min([], 0)).to eq(-1)
    end
  end
end
