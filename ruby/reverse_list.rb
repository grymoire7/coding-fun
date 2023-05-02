=begin
# Reverse a linked list
https://leetcode.com/problems/reverse-linked-list/
=end

require 'rspec/autorun'

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def to_s
    s = ''
    node = self
    loop do
      s << node.val.to_s << ' '
      node = node.next
      break if node.nil?
    end
    s
  end
end

# @param {ListNode} head
# @return {ListNode}
def reverse_list(head)
  return nil if head.nil?

  _next = head
  curr = nil
  loop do
    tmp = _next.next
    _next.next = curr
    curr = _next
    _next = tmp
    break if _next.nil?
  end
  curr
end

# ###############################################################################
# Tests
# ###############################################################################

RSpec.describe '#reverse_list' do
  let(:example1) { ListNode.new(1, ListNode.new(2, ListNode.new(3))) }
  let(:answer1) { '3 2 1 ' }
  let(:one_to_s) { '1 2 3 ' }

  describe 'ListNode#to_s' do
    it 'serializes to a string' do
      expect(example1.to_s).to eq(one_to_s)
    end
  end

  describe '#reverse_list' do
    it 'reverses example1' do
      expect(reverse_list(example1).to_s).to eq(answer1)
    end

    it 'reverses nil' do
      expect(reverse_list(nil)).to eq(nil)
    end
  end
end
