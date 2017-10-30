#!/usr/bin/env ruby

# Palindrome tester
#
# This code is not necessarily the *best* way to do this. The point of this
# exercise was to balance simplicity with an exploration of ruby's features.
# It's also light on exception handling.

# Palidrome doc
class Palindrome
  def self.palindrome?(input)
    normalized = input.downcase.gsub(/\s+/, '').gsub(/\W+/, '')
    normalized == normalized.reverse
  end
end

RSpec.describe Palindrome do
  describe '.palindrome?' do
    it 'tests for palindrome' do
      expect(Palindrome.palindrome?('oozaKazoo')).to be true
      expect(Palindrome
             .palindrome?('A man. A plan. A canal. Panama!')).to be true
      expect(Palindrome.palindrome?('a bba')).to be true
      expect(Palindrome.palindrome?('abba')).to be true
      expect(Palindrome.palindrome?('a')).to be true
      expect(Palindrome.palindrome?('.')).to be true
      expect(Palindrome.palindrome?('')).to be true
      expect(Palindrome.palindrome?('axba')).to be false
    end
  end
end
