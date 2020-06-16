=begin
# Best time to buy and sell stock III
## Description
Source: https://leetcode.com/problems/maximum-depth-of-binary-tree/
Given a binary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Note: A leaf is a node with no children.

Example:

Given binary tree [3,9,20,null,null,15,7],

   3
  / \
 9  20
   /  \
  15   7

return its depth = 3.

=end

require 'rspec/autorun'

# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# @param {TreeNode} root
# @return {Integer}
def max_depth(root)
  return 0 if root.nil?

  [max_depth(root.left) + 1, max_depth(root.right) + 1].max
end

# @param {Array<Integer>} ary
# @return {TreeNode}
def make_binary_tree(ary)
  # puts(ary.inspect)
  return nil unless ary.size
  return TreeNode.new(ary[0]) if ary.size == 1

  tree_nodes = ary.map { |val| TreeNode.new(val) }
  last_idx = tree_nodes.size / 2
  tree_nodes.unshift(nil) # let's do 1-based indexing

  1.upto(last_idx) do |i|
    current = tree_nodes[i]
    current.left = tree_nodes[i * 2]
    current.right = tree_nodes[i * 2 + 1]
    # puts "#{i}: #{current.val}, left: #{tree_nodes[left_idx]&.val}, right: #{tree_nodes[right_idx]&.val}"
  end

  # puts "Final tree: #{tree_nodes[1].inspect}"
  tree_nodes[1]
end

RSpec.describe '#max_depth' do
  describe '#max_depth' do
    it 'solves example 1' do
      tree = make_binary_tree([3, 9, 20, nil, nil, 15, 7])
      expect(max_depth(tree)).to eq(3)
    end
  end
end
