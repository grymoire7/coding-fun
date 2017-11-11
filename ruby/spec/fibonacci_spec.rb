require 'spec_helper'

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
