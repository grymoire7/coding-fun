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

# @param Array{Integer} a
# @return Integer
def find_min(a)
  return nil if a.nil? || a.empty?
  index = 0
  left = 0
  right = a.size - 1

  while (left <= right)
    mid = (left + right) / 2
    if a[mid] < a[index]
      index = mid
      right = mid - 1
    else
      left = mid + 1
    end
  end

  a[index]
end

RSpec.describe '#find_min' do
  describe '#find_min' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(find_min([4, 5, 6, 7, 0, 1, 2])).to eq(0)
    end

    it 'solves example 2' do
      expect(find_min([5, 5, 5, 5, 5, 1, 5])).to eq(1)
    end

    it 'handles nil' do
      expect(find_min(nil)).to eq(nil)
    end

    it 'handles empty array' do
      expect(find_min([])).to eq(nil)
    end
  end
end
