# frozen_string_literal: true

=begin
# Detect Cycle in Linked List

## Description


=end

require 'rspec/autorun'
# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next

  def initialize(val)
    @val = val
    @next = nil
  end
end

# @param {ListNode} head
# @return {Boolean}
def has_cycle(head)
  fast = head
  slow = head

  until fast.nil? || fast.next.nil?
    slow = slow.next
    fast = fast.next.next
    return true if slow == fast
  end
  false
end

RSpec.describe '#has_cycle' do
  describe '#has_cycle' do
    let(:list1) do
      head = ListNode.new(3)
      head.next = node1 = ListNode.new(2)
      head.next.next = ListNode.new(2)
      head.next.next.next = ListNode.new(0)
      head.next.next.next.next = ListNode.new(-4)
      head.next.next.next.next.next = node1
      head
    end

    it 'solves example 1' do
      expect(has_cycle(list1)).to eq(true)
    end

    it 'solves single node' do
      expect(has_cycle(ListNode.new(1))).to eq(false)
    end

    it 'handles empty array' do
      expect(has_cycle(nil)).to eq(false)
    end
  end
end
