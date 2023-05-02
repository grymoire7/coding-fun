# frozen_string_literal: true

=begin
# Insertion Sort 2

## Description
Source: https://www.hackerrank.com/challenges/insertionsort2/problem


=end

require 'rspec/autorun'

def insertion_sort(arr)
  # puts arr.join(' ')
  (0...(arr.size - 1)).each do |i|
    # puts "move arr[#{i + 1}] = #{arr[i + 1]} down" if arr[i] > arr[i + 1]
    if arr[i] > arr[i + 1]
      moved = false
      i.downto(0) do |j|
        next unless arr[j] < arr[i + 1]

        # puts "-- moving arr[#{i + 1}] = #{arr[i + 1]} to arr[#{j}] = #{arr[j]}"
        tmp = arr.delete_at(i + 1)
        arr.insert(j + 1, tmp)
        moved = true
        break
      end
      unless moved
        tmp = arr.delete_at(i + 1)
        arr.insert(0, tmp)
      end
    end
    puts arr.join(' ')
  end
  arr
end

RSpec.describe '#insertion_sort' do
  describe '#insertion_sort' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      arr = [1, 4, 3, 5, 6, 2]
      expect(insertion_sort(arr)).to eq(arr.sort)
    end

    it 'solves example 2' do
      arr = [3, 4, 1, 5, 6, 2]
      expect(insertion_sort(arr)).to eq(arr.sort)
    end
  end
end
