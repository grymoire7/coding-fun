require 'spec_helper'

RSpec.describe AlmostIncreasing do
  describe '.check' do
    it 'calculates almost increasing' do
      expect(AlmostIncreasing.check([0, 1, 5, 3])).to be(true)
      expect(AlmostIncreasing.check([8, 1, 5, 3])).to be(false)
      expect(AlmostIncreasing.check([5, 3])).to be(true)
      expect(AlmostIncreasing.check([3, 5])).to be(true)
      expect(AlmostIncreasing.check([1, 2, 1, 2])).to be(false)
      expect(AlmostIncreasing.check([1, 2, 5, 3, 5])).to be(true)
      expect(AlmostIncreasing.check([1, 2, 3, 4, 5, 3, 5, 6])).to be(false)
      expect(AlmostIncreasing.check([1, 2, 3, 4, 3, 6])).to be(true)
      expect(AlmostIncreasing.check([3, 5, 67, 98, 3])).to be(true)
    end
  end
end
