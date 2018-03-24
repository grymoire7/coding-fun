require 'spec_helper'

RSpec.describe IPolyArea do
  describe '.area' do
    it 'calculates n-interesting poly area' do
      expect(IPolyArea.area(1)).to eq(1)
      expect(IPolyArea.area(2)).to eq(5)
      expect(IPolyArea.area(3)).to eq(13)
      expect(IPolyArea.area(4)).to eq(25)
      expect(IPolyArea.area(5)).to eq(41)
    end
  end
end
