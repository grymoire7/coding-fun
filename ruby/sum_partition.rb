=begin
# Sum Partition
## Description
This problem was asked by Facebook.

Given a list of strictly positive integers, partition the list into 3
contiguous partitions which each sum up to the same value. If not possible,
return null.

For example, given the following list:
[3, 5, 8, 0, 8]

Return the following 3 partitions:
[ [3, 5], [8, 0], [8] ]

Which each add up to 8.
=end

require 'rspec/autorun'

def get_equal_thirds(arr)
  return nil if (arr.sum % 3).positive?

  sum = arr.sum / 3
  res = []
  curr = []
  curr_sum = 0

  arr.each do |elem|
    return nil if curr_sum + elem > sum

    curr_sum += elem
    curr << elem

    next unless curr_sum == sum

    res << curr
    curr = []
    curr_sum = 0
  end

  res
end

RSpec.describe '#word_break' do
  let(:example1) { [1, 2, 3, 6, 2, 2, 2] }
  let(:solution1) { [[1, 2, 3], [6], [2, 2, 2]] }
  let(:example2) { [1, 2, 3, 6] }
  let(:solution2) { nil }
  let(:example3) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:solution3) { nil }
  let(:example4) { [3, 5, 8, 0, 8] }
  let(:solution4) { [[3, 5], [8], [0, 8]] }

  describe '#word_break' do
    it 'solves example 1' do
      expect(get_equal_thirds(example1)).to eq(solution1)
    end

    it 'solves example 2' do
      expect(get_equal_thirds(example2)).to eq(solution2)
    end

    it 'solves example 3' do
      expect(get_equal_thirds(example3)).to eq(solution3)
    end

    it 'solves example 4' do
      expect(get_equal_thirds(example4)).to eq(solution4)
    end
  end
end
