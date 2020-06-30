require 'spec_helper'

RSpec.describe Roman do
  describe 'roman_for' do
    it 'turns 4 into IV' do
      expect(Roman.roman_for(4)).to eq 'IV'
    end

    it 'turns 3 into III' do
      expect(Roman.roman_for(3)).to eq 'III'
    end

    it 'turns 100 into C' do
      expect(Roman.roman_for(100)).to eq 'C'
    end

    it 'turns 53 into LIII' do
      expect(Roman.roman_for(53)).to eq 'LIII'
    end

    it 'turns 54 into LIV' do
      expect(Roman.roman_for(54)).to eq 'LIV'
    end

    it 'turns 2016 into MMXVI' do
      expect(Roman.roman_for(2016)).to eq 'MMXVI'
    end

    it 'turns 9 into IX' do
      expect(Roman.roman_for(9)).to eq 'IX'
    end

    it 'turns 1989 into MCMLXXXIX' do
      expect(Roman.roman_for(1989)).to eq 'MCMLXXXIX'
    end

    it 'turns 90 into XC' do
      expect(Roman.roman_for(90)).to eq 'XC'
    end

    it 'turns 900 into CM' do
      expect(Roman.roman_for(900)).to eq 'CM'
    end
  end

  describe 'int_for' do
    it 'turns IV into 4' do
      expect(Roman.int_for('IV')).to eq 4
    end

    it 'turns 3 into III' do
      expect(Roman.int_for('III')).to eq 3
    end

    it 'turns 100 into C' do
      expect(Roman.int_for('C')).to eq 100
    end

    it 'turns 53 into LIII' do
      expect(Roman.int_for('LIII')).to eq 53
    end

    it 'turns 54 into LIV' do
      expect(Roman.int_for('LIV')).to eq 54
    end

    it 'turns 2016 into MMXVI' do
      expect(Roman.int_for('MMXVI')).to eq 2016
    end

    it 'turns 9 into IX' do
      expect(Roman.int_for('IX')).to eq 9
    end

    it 'turns 1989 into MCMLXXXIX' do
      expect(Roman.int_for('MCMLXXXIX')).to eq 1989
    end

    it 'turns 90 into XC' do
      expect(Roman.int_for('XC')).to eq 90
    end

    it 'turns 900 into CM' do
      expect(Roman.int_for('CM')).to eq 900
    end
  end
end
