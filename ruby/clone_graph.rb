# frozen_string_literal: true

=begin
# Clone Graph
Source: https://leetcode.com/problems/clone-graph/

## Description
Given a reference of a node in a connected undirected graph.

Return a deep copy (clone) of the graph.

Each node in the graph contains a val (int) and a list (List[Node]) of its
neighbors.

class Node {
    public int val;
    public List<Node> neighbors;
}

## Test case format:

For simplicity sake, each node's value is the same as the node's index
(1-indexed). For example, the first node with val = 1, the second node with val
= 2, and so on. The graph is represented in the test case using an adjacency
list.

Adjacency list is a collection of unordered lists used to represent a finite
graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with val = 1. You must return the
copy of the given node as a reference to the cloned graph.

## Example 1:

Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
Output: [[2,4],[1,3],[2,4],[1,3]]
Explanation: There are 4 nodes in the graph.
1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).

## Example 2:

(1)

Input: adjList = [[]]
Output: [[]]
Explanation: Note that the input contains one empty list. The graph consists of
only one node with val = 1 and it does not have any neighbors.

## Example 3:

Input: adjList = []
Output: []
Explanation: This an empty graph, it does not have any nodes.

## Example 4:

(1)---(2)

Input: adjList = [[2],[1]]
Output: [[2],[1]]

## Constraints:

* 1 <= Node.val <= 100
* Node.val is unique for each node.
* Number of Nodes will not exceed 100.
* There is no repeated edges and no self-loops in the graph.
* The Graph is connected and all nodes can be visited starting from the given
  node.

=end

require 'rspec/autorun'
require 'set'

# Definition for a Node.
class Node
  attr_accessor :val, :neighbors

  def initialize(val = 0, neighbors = nil)
    @val = val
    neighbors = [] if neighbors.nil?
    @neighbors = neighbors
  end
end

# @param {Node} node
# @return {Node}
def clone_graph(node)
  return nil if node.nil?

  to_process = [node]
  node_map = { node => Node.new(node.val) }

  while to_process.size.positive?
    n = to_process.pop
    n.neighbors.each do |nbr|
      unless node_map.include?(nbr)
        node_map[nbr] = Node.new(nbr.val)
        to_process.push nbr
      end
      node_map[n].neighbors << node_map[nbr]
    end
  end

  node_map[node]
end

def clones?(node1, node2)
  hash1 = graph_to_hash node1
  hash2 = graph_to_hash node2

  hash1.each do |val, node|
    return false if hash2[val].nil?
    return false if hash2[val].equal? node
  end

  true
end

def show_graph(node, visited = nil)
  visited = Set.new if visited.nil?
  visited.add node

  print "#{node.val}: "
  puts node.neighbors.map { |n| n.val.to_s }.join(', ')

  node.neighbors.each do |n|
    show_graph(n, visited) unless visited.include?(n)
  end
end

def graph_to_hash(node, visited = nil)
  visited = {} if visited.nil?
  visited[node.val] = []

  node.neighbors.each do |nbr|
    visited[node.val] << nbr.val
    graph_to_hash(nbr, visited) unless visited.include?(nbr.val)
  end

  visited
end

def graph_to_array(node)
  node_hash = graph_to_hash(node)
  array_out = []

  1.upto(node_hash.size) do |i|
    array_out << node_hash[i]
  end

  array_out
end

def array_to_graph(input)
  nodes = input.each_with_index.map { |_, i| Node.new(i + 1) }
  nodes.unshift nil
  # puts nodes.inspect
  1.upto(input.size) do |val|
    node = nodes[val]
    # puts node.inspect
    input[val - 1].each do |nbr_val|
      # puts "  nbr_val: #{nbr_val}"
      node.neighbors << nodes[nbr_val]
    end
  end
  # puts "nodes[1]: #{nodes[1].inspect}"
  nodes[1]
end

RSpec.describe '#word_break' do
  let(:example1) { [[2, 4], [1, 3], [2, 4], [1, 3]] }
  let(:example2) { [[]] }

  describe '#clone_graph' do
    it 'solves example 1' do
      graph = array_to_graph(example1)
      # show_graph(graph)
      cloned = clone_graph(graph)
      # show_graph(cloned)
      answer = graph_to_array(cloned)

      expect(clones?(graph, cloned)).to eq(true)

      expect(answer).to eq(example1)
    end

    it 'solves example 2' do
      graph = array_to_graph(example2)
      cloned = clone_graph(graph)
      answer = graph_to_array(cloned)

      expect(clones?(graph, cloned)).to eq(true)
      expect(answer).to eq(example2)
    end
  end
end
