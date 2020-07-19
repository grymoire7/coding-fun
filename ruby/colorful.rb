# frozen_string_literal: true

=begin
# Is a number colorful?

## Description
Source: https://algorithms.tutorialhorizon.com/colorful-numbers/

Objective: Given a number, find out whether its colorful or not.

Colorful Number: When in a given number, product of every digit of a
sub-sequence are different. That number is called Colorful Number. See Example

Example:

Given Number : 3245
Output : Colorful
Number 3245 can be broken into parts like 3 2 4 5 32 24 45 324 245.

This number is a colorful number, since product of every digit of a sub-sequence
are different.

That is, 3 2 4 5 (3*2)=6 (2*4)=8 (4*5)=20, (3*2*4)= 24 (2*4*5)= 40

Given Number : 326
Output : Not Colorful.
326 is not a colorful number as it generates 3 2 6 (3*2)=6 (2*6)=12.

=end

require 'rspec/autorun'

def colorful?(number)
  pset = powerset(number.digits)
  pset.shift # drop []
  mset = pset.map { |arr| arr.inject(:*) }

  mset.size == mset.sort.uniq.size
end

def powerset(arr)
  pset = [[]]
  arr.each do |arr_elem|
    len = pset.size
    for j in (0...len)
      pset << (pset[j] + [arr_elem])
    end
  end
  pset
end

RSpec.describe '#colorful?' do
  describe '#colorful?' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(colorful?(3245)).to eq(true)
    end

    it 'solves example 2' do
      expect(colorful?(326)).to eq(false)
    end
  end
end
