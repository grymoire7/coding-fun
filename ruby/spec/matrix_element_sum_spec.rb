require 'spec_helper'

RSpec.describe MatrixElementSum do
  describe '.sum' do
    it 'calculates almost increasing' do
      expect(MatrixElementSum.sum([
        [0, 1, 1, 2],
        [0, 5, 0, 0],
        [2, 0, 3, 3]
      ])).to eq(9)
    end
  end
end
