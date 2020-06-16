# https://leetcode.com/problems/add-two-numbers/
require 'rspec/autorun'

# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end

  def self.make(val)
    last = nil
    val.to_s.chars.reverse.each do |c|
      last = ListNode.new(c.to_i, last)
    end
    last
  end

  def to_int
    to_string.to_i
  end

  def to_rint
    to_string.reverse.to_i
  end

  def to_s
    "val: #{@val}, next: #{@next}"
  end

  private

  def to_string
    int_str = ''
    node = self
    loop do
      # puts "node.val = #{node.val}, node.next = #{node.next}"
      int_str << node.val.to_s
      node = node.next
      # puts "node.val = #{node.val}, node.next = #{node.next}"
      # puts "int_str = #{int_str}, next = #{node}"
      break if node.nil?
    end
    int_str
  end
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  ListNode.make(l1.to_rint + l2.to_rint)
end

def two_sum(nums, target)
  nums.each_with_index do |num, idx|
    prey = target - num
    search_idx = nums.rindex(prey)
    return [idx, search_idx] if search_idx && search_idx != idx
  end
  [0, 0]
end


RSpec.describe '#two_sum' do
  describe '#two_sum' do
    it 'works' do
      expect(two_sum([2, 7, 15, 11], 17)).to eq([0, 2])
      expect(two_sum([3, 3], 6)).to eq([0, 1])
      expect(two_sum([-1,-2,-3,-4,-5], -8)).to eq([2, 4])
      expect(two_sum([3,2,4], 6)).to eq([1,2])
    end
  end

  describe '#add_two' do
    let(:l1) { ListNode.new(2, ListNode.new(4, ListNode.new(3))) }
    let(:l2) { ListNode.new(5, ListNode.new(6, ListNode.new(4))) }
    let(:a1) { ListNode.new(7, ListNode.new(0, ListNode.new(8))) }

    it 'works' do
      puts "l1 = #{l1}"
      expect(add_two_numbers(l1, l2).to_rint).to eq(708)
    end
  end
end

