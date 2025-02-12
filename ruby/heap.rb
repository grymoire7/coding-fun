# frozen_string_literal: true

# Min heap
#
# Description
#

require 'rspec/autorun'

class Heap
  attr_accessor :heap

  def initialize
    @heap = []
  end

  def size = heap.size

  def add(value)
    # toss it on the bottom of the heap and bubble it up
    heap << value
    index = size - 1

    while value_at(index) < value_at(parent_index(index))
      heap[index], heap[parent_index(index)] = heap[parent_index(index)], heap[index]
      index = parent_index(index)
    end

    # puts "add #{value}, #{@heap}"
  end

  def right_index(index) = 2 * index + 2

  def left_index(index)  = 2 * index + 1

  def parent_index(index) = [(index - 1) / 2, 0].max

  def value_at(index) = heap[index]

  def leaf?(index) = index >= size / 2

  def min = heap[0]
end

RSpec.describe 'Heap' do
  describe '#add' do
    it 'solves example 1' do
      h = Heap.new
      h.add 5
      h.add 8
      h.add 1
      h.add 2
      expect(h.min).to eq(1)
    end

    it 'solves example 2' do
      h = Heap.new
      h.add 5
      h.add 9
      h.add 8
      h.add 3
      h.add 2
      expect(h.min).to eq(2)
    end

    it 'finds min of single value' do
      h = Heap.new
      h.add 7
      expect(h.min).to eq(7)
    end
  end
end
