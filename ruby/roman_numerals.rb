require 'rspec'

# Roman numeral converter
class Roman
  PLACES = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I']
  ].freeze

  def self.roman_for(number)
    return '' if number.zero?
    ''.tap do |result|
      PLACES.each_with_index do |rule, _index|
        current_tens, current_place = rule
        val, number = number.divmod(current_tens)
        # puts "for #{number}: rule:#{rule}, #{val}, #{number}"
        next if val.zero?
        result << current_place * val
        break
      end
      return result << Roman.roman_for(number)
    end
  end
end

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
end
