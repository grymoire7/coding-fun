# frozen_string_literal: true

# Look-and-say sequence
# Source: https://en.wikipedia.org/wiki/Look-and-say_sequence

## Description

require 'rspec/autorun'

# Returns the first n terms of the look and say sequence.
# @param {Integer} n
# @return Integer[][]
def look_say(n)
  return '' if n.nil? || !n.positive?

  ans = ''
  term = '1'

  n.times do
    puts term
    ans += term
    term = next_term(term)
  end

  ans
end

def next_term(term)
  return '' if term.nil? || term.empty?

  curr = term[0]
  count = 0
  next_term = ''

  (0...term.size).each do |i|
    c = term[i]

    # puts "c = #{c}, count = #{count}, next_term = #{next_term}"
    if c == curr[0]
      count += 1
    else
      next_term += "#{count}#{curr[0]}"
      curr = c
      count = 1
    end
  end
  next_term += "#{count}#{curr[0]}"

  # puts "---------- next_term = #{next_term}"
  next_term
end

RSpec.describe '#look_say' do
  describe '#look_say' do
    let(:tree) { Node.new(1, left: Node.new(3), right: Node.new(4)) }

    it 'solves example 1' do
      expect(look_say(10)).to eq('1112112111112213122111311222111132132113113121113122113211311123113112211')
    end

    it 'handles 0 case' do
      expect(look_say(0)).to eq('')
    end

    it 'handles nil case' do
      expect(look_say(nil)).to eq('')
    end
  end
end
