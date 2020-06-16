# https://interviewing.io/recordings/Javascript-Google-19
require 'rspec/autorun'

class Node
  attr_accessor :children, :leaf_value

  def initialize(leaf_value = nil)
    @children = Hash.new { |h, k| h[k] = Node.new }
    @leaf_value = leaf_value
  end
end

class Trie
  def initialize
    @root = Node.new
  end

  def find(key_string, node = root)
    # puts "find: node = #{.inspect}"
    # puts "find: looking for = #{key_string}"
    if key_string.size == 1
      # puts "find: children = #{node.children.inspect}"
      # puts "find: key_string = #{key_string}"
      # puts "find: key_value = #{node.children[key_string].leaf_value}"
      return node.children[key_string].leaf_value
    else
      child_key = key_string[1..-1]
      # puts "find: child_key = #{child_key}"
      next_node = node.children[key_string[0]]
      find(child_key, next_node)
    end
  end

  def add(key_string, value_string, node = root)
    # puts "add: node = #{node.inspect}"
    if key_string.size == 1
      leaf_node = Node.new(value_string)
      node.children[key_string] = leaf_node
      # puts "children = #{node.children.size}"
      # puts "children = #{node.children}"
    else
      child_key = key_string[1..-1]
      next_node = node.children[key_string[0]]
      add(child_key, value_string, next_node)
    end
  end

  def to_s
    out = ''
    node = root
    until node.nil?
      out += "> #{node.children.inspect}, #{node.leaf_value}"
      node = node.children.empty? ? nil : node.children[0]
    end
    out
  end

  private

  attr_reader :root
end

RSpec.describe 'Trie' do
  let(:trie) { Trie.new }

  describe '#add, #find' do
    it 'works' do
      trie.add('dog', 'dogs')
      trie.add('dogs', 'dogs')
      trie.add('doggie', 'good boy')
      # puts trie
      expect(trie.find('dog')).to eq('dogs')
      expect(trie.find('dogs')).to eq('dogs')
      expect(trie.find('doggie')).to eq('good boy')
    end
  end
end
