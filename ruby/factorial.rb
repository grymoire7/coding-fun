#!/usr/bin/env ruby

# Factorial calculator
#
# This code is not necessarily the *best* way to do this. The point of this
# exercise was to balance simplicity with an exploration of ruby's features.
# It's also light on exception handling.

# Factorial calculator
#
class Factorial
  def self.factorial(n)
    # p "class factorial #{n}"
    (1..n).inject(:*) || 1
  end

  def self.factorial_r(n)
    # p "class factorial_r #{n}"
    return 1 if n <= 1
    n * factorial_r(n - 1)
  end
end

RSpec.describe Factorial do
  # playing with rspec
  describe '.myfactorial' do
    subject { Factorial.factorial(5) }
    it { is_expected.not_to eq(0) }
    it { is_expected.to eq(120) }
  end

  shared_examples 'a factorial' do |method_name = nil|
    let(:address) { Factorial }

    it 'creates the method' do
      expect(address).to respond_to method_name
    end

    it 'calculates factorials' do
      # p "address = #{address}"
      # p "method_name = #{method_name}"
      expect(address.send(method_name, 5)).to eq(120)
      expect(address.send(method_name, 4)).to eq(24)
      expect(address.send(method_name, 3)).to eq(6)
      expect(address.send(method_name, 2)).to eq(2)
      expect(address.send(method_name, 1)).to eq(1)
      expect(address.send(method_name, 0)).to eq(1)
      expect(address.send(method_name, -1)).to eq(1)
    end
  end

  describe 'dynamic example' do
    it_behaves_like 'a factorial', :factorial
    it_behaves_like 'a factorial', :factorial_r
  end
end
