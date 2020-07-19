# frozen_string_literal: true

=begin
# Min heap

## Description

=end

require 'rspec/autorun'

class Heap
  attr_accessor :heap

  def initialize
    @heap = []
  end

  def size
    @heap.size
  end

  def add(value)
    # toss it on the bottom of the heap and bubble it up
    @heap << value
    index = size - 1

    while value_at(index) < value_at(parent_index(index))
      @heap[index], @heap[parent_index(index)] = @heap[parent_index(index)], @heap[index]
      index = parent_index(index)
    end

    # puts "add #{value}, #{@heap}"
  end

  def right_index(index)
    2*index + 2
  end

  def left_index(index)
    2*index + 1
  end

  def parent_index(index)
    [(index - 1) / 2, 0].max
  end

  def value_at(index)
    @heap[index]
  end

  def leaf?(index)
    index >= size / 2
  end

  def min
    @heap[0]
  end
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
