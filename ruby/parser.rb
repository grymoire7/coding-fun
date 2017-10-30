#!/usr/bin/env ruby

# Parse an invented format.  Parse a provided string and return objects
# representing the parsed content. The format is described below using EBNF and
# a bit of regex. Each line describes a token in the grammar followed by
# examples.  In person, they just gave a few examples of each.
#
#   * integer ::=  `"i", \d+, "e";`  i10e, i4e
#   * string  ::= `\d+, ":", .{\1}`, 2:ab, 4:abcd
#   * array   ::= `"a", (integer | string | array )+, "e"`, a2:abi34ee
#   * dict    ::= `"h", (string, (integer | string | array | dict))+, "e"`, h2:abi34ee
#
# This code is not necessarily the *best* way to do this. The point of this
# exercise was to balance simplicity with an exploration of ruby's features.
# It's also light on exception handling.

require 'strscan'

# Parser parses an invented format.
#
class Parser
  DEBUG = false

  def self.parse(input)
    new(input).parse
  end

  def initialize(input)
    @input = input
    @scanner = StringScanner.new(@input)
  end

  def reset(input)
    @input = input
    @scanner = StringScanner.new(@input)
    self
  end

  def unparsed
    @scanner.rest
  end

  def debug(msg, obj = nil)
    msg = "== Debug: #{msg}" unless msg.class != String
    warn msg if DEBUG
    warn obj if DEBUG && !obj.nil?
  end

  def parse_int
    ret = nil
    intstring = @scanner.scan(/^i\d+e/)
    return nil if intstring.nil?
    integer = Regexp.last_match[1].to_i if /^i(\d+)e/ =~ intstring
    ret = integer if integer
    ret
  end

  def parse_string
    ret = nil
    return nil if @input !~ /^\d+:/
    matchdata = /^(\d+):/.match(@input)
    integer = matchdata[1].to_i
    return nil if integer <= 0

    regex = '^\d+:(.{' + integer.to_s + '})'
    parse_string = @scanner.scan(/#{regex}/)
    return nil if parse_string.nil? || parse_string.empty?

    matchdata = /#{regex}/.match(parse_string)
    string = matchdata[1] if matchdata && !matchdata.to_a.empty? # length > 0

    ret = string if string
    ret
  end

  def parse_array
    return [] if @input !~ /^a/
    @scanner.scan(/a/)

    # Parse the rest with a new parser which should fail when it encounters the
    # unmatched 'e' for the end of this array.
    parse_string = @scanner.rest
    parser = Parser.new(parse_string)
    ret = parser.parse
    @scanner.string = parser.unparsed

    @scanner.scan(/e/)
    ret
  end

  def parse_dict
    ret = {}
    return ret if @input !~ /^d/
    @scanner.scan(/d/)

    # Parse the rest with a new parser which should fail when it encounters the
    # unmatched 'e' for the end of this dict.
    parse_string = @scanner.rest
    parser = Parser.new(parse_string)
    ary = parser.parse
    debug 'parsed dict array', ary
    ret = Hash[ary.each_slice(2).to_a]
    debug 'parsed dict ret', ret
    @scanner.string = parser.unparsed

    @scanner.scan(/e/)
    ret
  end

  def parse
    parsed = []
    return parsed if @input.nil? || @input.length.zero?
    debug "Parse: \"#{@input}\""
    loop do
      break if @input.length.zero?
      case @input
      when /^i\d+e/                  # integer
        integer = parse_int
        debug "integer: #{integer}"
        parsed << integer
      when /^(\d+):.{1,}/            # string
        string = parse_string
        debug "string: #{string}"
        parsed << string
      when /^a/                      # array
        ary = parse_array
        debug "array: #{ary}, parsed: #{parsed}"
        parsed << ary
        debug "array: #{ary}, parsed: #{parsed}"
      when /^d/                      # dictionary
        dict = parse_dict
        debug "dict: #{dict}, parsed: #{parsed}"
        parsed << dict
        debug "dict: #{dict}, parsed: #{parsed}"
      else
        debug "unrecognized token at: #{@input}"
        break
      end
      @input = @scanner.rest
    end
    parsed
  end

  # A class/static version.
  def self.parse_int(input)
    Parser.new(input).parse_int
  end

  # A class/static version.
  def self.parse_string(input)
    Parser.new(input).parse_string
  end

  # A class/static version.
  def self.parse(input)
    Parser.new(input).parse
  end
end

RSpec.describe Parser do
  before do
    @parser = Parser.new('test string')
  end

  describe '.parse' do
    it 'parse int' do
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
