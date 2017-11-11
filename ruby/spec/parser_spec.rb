require 'spec_helper'

RSpec.describe Parser do
  before do
    @parser = Parser.new('test string')
  end

  describe '.parse' do
    it 'parses int' do
      expect(Parser.parse('i10e')).to eq([10])
    end
  end

  describe '.parse_int' do
    it 'parses int from class/static method' do
      expect(Parser.parse_int('i10e')).to eq(10)
    end
  end

  describe '#parse_int' do
    it 'parses int from class/static method' do
      expect(Parser.parse_int('i10e')).to eq(10)
    end
    it 'parses integers' do
      expect(@parser.reset('i10e').parse_int).to eq(10)
      expect(@parser.reset('i8e').parse_int).to eq(8)
      expect(@parser.reset('i0e').parse_int).to eq(0)
      expect(@parser.reset('i07e').parse_int).to eq(7)
    end
    it 'ignores integer bad input' do
      expect(@parser.reset('x10e').parse_int).to eq(nil)
      expect(@parser.reset('i1.0e').parse_int).to eq(nil)
      expect(@parser.reset('i10x').parse_int).to eq(nil)
    end
  end

  describe '#parse_array' do
    it 'parses simple array' do
      expect(@parser.reset('ai8ei3ee').parse_array).to match_array([8, 3])
      expect(@parser.reset('ai22ei7ei1ee').parse_array).to match_array([22, 7, 1])
    end
  end

  describe '#parse_dict' do
    it 'parses simple dict' do
      expect(@parser.reset('di8ei3ee').parse_dict).to include(8 => 3)
      expect(@parser.reset('di8e3:abce').parse_dict).to include(8 => 'abc')
      expect(@parser.reset('di1ei2ei10ei11ee').parse_dict).to include(1 => 2, 10 => 11)
    end
  end

  describe '#parse_string' do
    it 'parses strings' do
      expect(@parser.reset('2:ab').parse_string).to eq('ab')
    end
    it 'ignores bad string input' do
      expect(@parser.reset('i2:ab').parse_string).to eq(nil)
      expect(@parser.reset('2:b').parse_string).to eq(nil)
      expect(@parser.reset('0:b').parse_string).to eq(nil)
      expect(@parser.reset('100:b').parse_string).to eq(nil)
    end
  end

  describe '#parse' do
    it 'handles bad initialization' do
      expect(@parser.reset('').parse).to match_array([])
      # expect(@parser.reset(nil).parse).to match_array([])
    end
    it 'parses integer' do
      expect(@parser.reset('i10e').parse).to match_array([10])
    end
    it 'parses integer and string' do
      expect(@parser.reset('2:abi1986e').parse).to match_array(['ab', 1986])
      expect(@parser.reset('i1986e2:ab').parse).to match_array([1986, 'ab'])
    end
    it 'parses integer and integer' do
      expect(@parser.reset('i1986ei2017e').parse).to match_array([1986, 2017])
    end
    it 'parses integer, array, integer' do
      expect(@parser.reset('i1986eai1ei2eei2017e').parse)
        .to match_array([1986, [1, 2], 2017])
    end
    it 'parses dictionary' do
      expect(@parser.reset('di8ei3ee').parse).to match_array([{ 8 => 3 }])
      expect(@parser.reset('di8e3:abce').parse).to match_array([{ 8 => 'abc' }])
    end
  end
end
