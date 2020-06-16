=begin
# Company technical phone screen
## Description
Given an org chart as a string in this format:

  "employee_name:employee_id:manager_id,employee_name:employee_id:manager_id,..."

Example:
  "Bob Barnes:1:0,Alice Anderson:2:1,Carl Carter:3:1,David Disher:4:2"

Print an org chart in the following format:

Bob Barnes
  Alice Anderson
    David Disher
  Carl Carter
=end

require 'rspec/autorun'

Person = Struct.new(:name, :id, :mgr_id)

class TreeNode
  attr_accessor :person, :children

  def initialize(person = nil)
    @person = person
    @children = []
  end
end

# This is the function under test.
#
# @param {String} data_string
# @return {String}
def make_org_chart(data_string)
  node_hash = create_node_hash(data_string)
  org_tree = create_org_tree(node_hash)
  render(org_tree)
end


# ------------------------------------------------------------------------------
# @param {String} data_string
# @return {Hash}
def create_node_hash(data_string)
  nodes = {}
  records = data_string.split(',')
  records.each do |r|
    name, id, mgr_id = r.split(':')
    person = Person.new(name, id, mgr_id)
    nodes[id] = TreeNode.new(person)
    # puts person
  end
  nodes
end

# @param {Hash} node_hash
# @return {TreeNode}
def create_org_tree(node_hash)
  root = TreeNode.new(Person.new('root'))
  node_hash.values.each do |node|
    # put node in manager's children array
    mgr_id = node.person.mgr_id
    manager_node = node_hash[mgr_id] || root
    manager_node.children << node
  end
  root
end

# @param {TreeNode} org_tree
# @return {String}
def render(org_tree, indent = 0)
  return unless org_tree

  rendered = ''
  # show orgs of all children
  org_tree.children.each do |node|
    rendered << ' ' * indent
    rendered << node.person.name << "\n"
    rendered << render(node, indent + 2)
  end

  rendered
end

# ###############################################################################
# Tests
# ###############################################################################

RSpec.describe '#make_org_chart' do
  let(:example1) { 'Bob Barnes:1:0,Alice Anderson:2:1,Carl Carter:3:1,David Disher:4:2' }
  let(:answer1) { "Bob Barnes\n  Alice Anderson\n    David Disher\n  Carl Carter\n" }

  let(:example2) { 'Bob:1:0,Alice:2:1,Carl:3:1,David:4:2,Edward:5:0' }
  let(:answer2) { "Bob\n  Alice\n    David\n  Carl\nEdward\n" }

  describe '#make_org_chart' do
    it 'solves example 1 - basic' do
      chart = make_org_chart(example1)
      expect(chart).to eq(answer1)
    end

    it 'solves example 2 - multiple at top level' do
      chart = make_org_chart(example2)
      expect(chart).to eq(answer2)
    end
  end
end
