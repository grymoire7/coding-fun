require 'spec_helper'

RSpec.describe ChangeMaker do
  it 'is greedy' do
    expect(ChangeMaker.change_for(100)).to eq([25, 25, 25, 25])
    expect(ChangeMaker.change_for(38)).to eq([25, 10, 1, 1, 1])
  end

  it 'is efficient' do
    expect(ChangeMaker.change_for(12)).to eq([10, 1, 1])
    expect(ChangeMaker.change_for(17)).to eq([10, 5, 1, 1])
  end
end
