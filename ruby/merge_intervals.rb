=begin
# Merge Intervals
## Description
Source: https://leetcode.com/problems/merge-intervals/

Given a collection of intervals, merge all overlapping intervals.

Example 1:

Input: [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].

Example 2:

Input: [[1,4],[4,5]]
Output: [[1,5]]
Explanation: Intervals [1,4] and [4,5] are considered overlapping.
=end

require 'rspec/autorun'
require 'set'

# @param {Integer[][]} intervals
# @return {Integer[][]}
def merge(intervals)
  return [] if intervals.nil? || intervals.empty?

  intervals.sort!
  merged = []
  curr = intervals.first
  merged << curr
  intervals[1..-1].each do |x|
    # if x overlaps curr
    if x.first <= curr.last
      # merge x to curr
      curr[0] = [curr[0], x[0]].min
      curr[1] = [curr[1], x[1]].max
    else
      curr = x
      merged << curr
    end
  end
  merged
end


RSpec.describe '#merge' do
  let(:dict1) { %w(leet code) }

  describe '#merge' do
    it 'solves example 1' do
      expect(merge([[1,3],[2,6],[8,10],[15,18]])).to eq([[1,6],[8,10],[15,18]])
    end

    it 'solves example 2' do
      expect(merge([[1,4],[4,5]])).to eq([[1,5]])
    end

    it 'solves example 3' do
      expect(merge([])).to eq([])
    end

    it 'solves example 4' do
      expect(merge(nil)).to eq([])
    end
  end
end
