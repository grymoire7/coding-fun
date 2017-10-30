#!/usr/bin/env ruby

# Fibonacci calculator
#
# This code is not necessarily the *best* way to do this. The point of this
# exercise was to balance simplicity with an exploration of ruby's features.
# It's also light on exception handling.

# Fionacci calculates elemens of the Fibonacci sequence.
#
class Fibonacci
  def self.upto(n)
    return 0 if n <= 0
    x1, x2 = [0, 1]
    0.upto(n - 1) { x1 += x2; x1, x2 = x2, x1 }
    x1
  end

  def self.array_upto(n)
    ret = []
    return ret if n <= 0
    x1, x2 = [0, 1]
    0.upto(n - 1) { ret << x2; x1 += x2; x1, x2 = x2, x1 }
    ret
  end
end

RSpec.describe Fibonacci do
  describe '.upto' do
    it 'calculates nth fibonacci number' do
      expect(Fibonacci.upto(-1)).to eq(0)
      expect(Fibonacci.upto(0)).to eq(0)
      expect(Fibonacci.upto(1)).to eq(1)
      expect(Fibonacci.upto(2)).to eq(1)
      expect(Fibonacci.upto(3)).to eq(2)
      expect(Fibonacci.upto(4)).to eq(3)
      expect(Fibonacci.upto(5)).to eq(5)
      expect(Fibonacci.upto(6)).to eq(8)
    end
  end

  describe '.array_upto' do
    it 'calculate fibonacci sequence to n' do
      expect(Fibonacci.array_upto(-1)).to eq([])
      expect(Fibonacci.array_upto(0)).to eq([])
      expect(Fibonacci.array_upto(1)).to eq([1])
      expect(Fibonacci.array_upto(2)).to eq([1, 1])
      expect(Fibonacci.array_upto(3)).to eq([1, 1, 2])
      expect(Fibonacci.array_upto(4)).to eq([1, 1, 2, 3])
      expect(Fibonacci.array_upto(5)).to eq([1, 1, 2, 3, 5])
      expect(Fibonacci.array_upto(6)).to eq([1, 1, 2, 3, 5, 8])
      expect(Fibonacci.array_upto(7)).to eq([1, 1, 2, 3, 5, 8, 13])
    end
  end
end
