# frozen_string_literal: true

# Find minimum depth of a binary tree
#
# Given a binary tree, find its minimum depth. The minimum depth is the number
# of nodes along the shortest path from the root node down to the nearest leaf node.
#
# Example:
# Given binary tree [3,9,20,null,null,15,7],
#
#    3
#   / \
#  9  20
#    /  \
#   15   7
#
# return its minimum depth = 2.

class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  # Helper method to build a binary tree from an array
  # Not required for the solution
  def self.build_from_array(arr)
    return if arr.empty?

    root = TreeNode.new(arr.shift)
    queue = []
    queue.push(root)

    until queue.empty?
      node = queue.shift

      left_value = arr.shift
      right_value = arr.shift

      if left_value
        node.left = TreeNode.new(left_value)
        queue.push(node.left)
      end

      if right_value
        node.right = TreeNode.new(right_value)
        queue.push(node.right)
      end
    end

    root
  end
end

# Let's create a solution using DFS
def min_depth_dfs(root)
  return 0 if root.nil?

  left = min_depth_dfs(root.left)
  right = min_depth_dfs(root.right)

  if left.zero? || right.zero?
    left + right + 1
  else
    [left, right].min + 1
  end
end

# Now let's create a solution using BFS
def min_depth_bfs(root)
  return 0 if root.nil?

  queue = []
  queue.push(root)
  depth = 1

  until queue.empty?
    size = queue.size

    size.times do
      node = queue.shift

      # when we find the first leaf node, we return the depth
      return depth if node.left.nil? && node.right.nil?

      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end

    depth += 1
  end
end

# The BFS solution is more efficient than the DFS solution because it stops
# as soon as it finds the first leaf node. The DFS solution will traverse the
# entire tree before returning the minimum depth.

root = TreeNode.new(3)
root.left = TreeNode.new(9)
root.right = TreeNode.new(20)
root.right.left = TreeNode.new(15)
root.right.right = TreeNode.new(7)

puts min_depth_dfs(root) => 2
puts min_depth_bfs(root) => 2

# root = TreeNode.build_from_array([3, 9, 20, nil, nil, 15, 7])
# puts min_depth_dfs(root) => 2
# puts min_depth_bfs(root) => 2
