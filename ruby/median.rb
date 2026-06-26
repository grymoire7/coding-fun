# frozen_string_literal: true

# Find the median of an unsorted stream of integers.
#
# Source: InstaByte
#
## Description

require 'rspec/autorun'

class MedianFinder
  def initialize
    @data = []
  end

  # do sorted insert using besearch_index
  # (log n) time complexity for insertion
  def add_num(num)
    return unless num.is_a?(Numeric)

    index = @data.bsearch_index { |x| x >= num } || @data.size
    @data.insert(index, num)
  end

  def find_median
    return if @data.empty?

    mid = @data.size / 2
    if @data.size.odd?
      @data[mid]
    else
      (@data[mid - 1] + @data[mid]) / 2.0
    end
  end
end

# This implementation uses two heaps to maintain the lower and upper halves of the data.
# The left heap is a max heap (simulated using negative values in a min heap),
# and the right heap is a min heap. This allows for efficient median finding.
# On insertion, the sort is O(n log n). This seems inefficient since the arrays are
# already sorted.
class MedianFinderHeap
  def initialize
    @left  = [] # max heap
    @right = [] # min heap
  end

  # Add a number to the data structure.
  # O(n log n) time complexity due to sorting after each insertion.
  def add_num(num)
    if @left.empty? || num <= -@left.first
      @left << -num
      @left.sort!
    else
      @right << num
      @right.sort!
    end

    balance_heaps
  end

  def find_median
    return if @left.empty? && @right.empty?

    if @left.size > @right.size
      -@left.first
    elsif @left.size < @right.size
      @right.first
    else
      (-@left.first + @right.first) / 2.0
    end
  end

  private

  def balance_heaps
    return if (@left.size - @right.size).abs <= 1

    if @left.size > @right.size + 1
      @right << -@left.shift
      @right.sort!
    elsif @right.size > @left.size + 1
      @left << -@right.shift
      @left.sort!
    end
  end
end

RSpec.describe '#find_median' do
  let(:finder) { MedianFinder.new }

  describe 'happy path' do
    it 'adds numbers and finds the median' do
      finder.add_num(1)
      expect(finder.find_median).to eq(1.0)

      finder.add_num(2)
      expect(finder.find_median).to eq(1.5)

      finder.add_num(3)
      expect(finder.find_median).to eq(2.0)

      finder.add_num(4)
      expect(finder.find_median).to eq(2.5)

      finder.add_num(5)
      expect(finder.find_median).to eq(3.0)
    end
  end

  describe 'empty stream' do
    it 'returns nil when no numbers are added' do
      expect(finder.find_median).to eq(nil)
    end
  end
end
