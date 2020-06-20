# frozen_string_literal: true

=begin
# Binary average - bfs

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

  ans = []
  depth = 0
  curr_sum = 0
  curr_num = 0
  queue = [[tree, depth]]

  loop do
    curr = queue.pop
    curr_node, curr_depth = curr

    if depth != curr_depth
      # puts "depth = #{depth}, curr_depth = #{curr_depth}"
      depth = curr_depth
      ans << Float(curr_sum) / curr_num
      curr_sum = 0
      curr_num = 0
    end

    curr_sum += curr_node.value
    curr_num += 1

    queue.unshift [curr_node.left,  curr_depth + 1] if curr_node.left
    queue.unshift [curr_node.right, curr_depth + 1] if curr_node.right

    break if queue.empty?
  end

  ans << Float(curr_sum) / curr_num

  ans
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
