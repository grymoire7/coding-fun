# frozen_string_literal: true

# ## Description
#
# Given an array-of-arrays like [[5,6], [7], [8,9]], return each
# distinct combination which can be built by taking one entry from each of the
# component arrays. For this example, one acceptable combination would be [5,
# 7, 8], where we take the 5 from the first array, the 7 from the second array
# and the 8 from the third array. Another combination would be [5, 7, 9].
#
# Source: https://www.vector-logic.com/blog/posts/enumerating-combinations-with-ruby-arrays
#
# Example:
#
# Given input array = [ [5, 6], [7], [8, 9] ],
#
# The requested combinations are:
# [
#   [5, 7, 8],
#   [5, 7, 9],
#   [6, 7, 8],
#   [6, 7, 9]
# ]

require 'rspec/autorun'

def easy_combinations(array_of_arrays)
  array_of_arrays[0].product(*array_of_arrays[1...])
end

def combinations(array_of_arrays)
  seed = array_of_arrays[0].map { |a| Array(a) }

  array_of_arrays[1...].reduce(seed) do |solutions, arr|
    product = []
    solutions.each do |element|
      arr.each do |value|
        product << element + [value]
      end
    end
    product
  end
end

# ------------
RSpec.describe 'combinations' do
  let(:example1) { [[5, 6], [7], [8, 9]] }

  let(:answer1) do
    [
      [5, 7, 8],
      [5, 7, 9],
      [6, 7, 8],
      [6, 7, 9]
    ]
  end

  let(:cases) do
    [
      [[0, 1], [2, 3], [4, 5]],
      [[1, 2, 3], [5], [6]],
      [[0, 1, 2], [3, 4], [5, 6, 7]]
    ]
  end

  describe '#easy_combinations' do
    it 'solves example 1' do
      expect(easy_combinations(example1)).to eq(answer1)
    end
  end

  describe '#combinations' do
    it 'solves example 1' do
      expect(combinations(example1)).to eq(answer1)
    end

    it 'solves other cases' do
      cases.each do |c|
        expect(combinations(c)).to eq(easy_combinations(c))
      end
    end
  end
end
