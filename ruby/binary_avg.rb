# frozen_string_literal: true

=begin
# Binary average

Source: https://www.facebook.com/careers/life/interview_prep_video/?token=41LIsCS1BPDw2q7Tf5UChyebEYXgxWomSeOJZLlbJE6PqrmWZP61QXkdZ8kgjNg0&id=844358515648985

## Description

Given a binary tree of integers, return the average of nodes
at each level in an array.

=end

require 'rspec/autorun'

class Node
  attr_accessor :value, :left, :right

  def initialize(value, left: nil, right: nil)
    @value = value
    @left = left
    @right = right
  end
end

# @param {Node} tree
# @return {Array[Integer]}
def get_averages(tree)
  return [] if tree.nil?

  level_hash = Hash.new { |h, k| h[k] = [] }

  collect(tree, level_hash)

  # ???? values.sort?
  level_hash.values.sort.map { |x| x.sum(0.0) / x.size }
end

def collect(node, data, depth = 0)
  return if node.nil?

  data[depth] << node.value
  collect(node.left, data, depth + 1)
  collect(node.right, data, depth + 1)
end

RSpec.describe '#get_averages' do
  describe '#get_averages' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(get_averages(tree)).to eq([1, 3.5])
    end

    it 'handles empty array' do
      expect(get_averages(nil)).to eq([])
    end
  end
end
