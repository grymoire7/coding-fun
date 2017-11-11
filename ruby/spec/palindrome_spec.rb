require 'spec_helper'

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
