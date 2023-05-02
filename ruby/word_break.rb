=begin
# Word Break
## Description
Source: https://leetcode.com/problems/word-break/

Given a non-empty string s and a dictionary wordDict containing a list of
non-empty words, determine if s can be segmented into a space-separated sequence
of one or more dictionary words.

Note:

The same word in the dictionary may be reused multiple times in the segmentation.
You may assume the dictionary does not contain duplicate words.

Example 1:

Input: s = "leetcode", wordDict = ["leet", "code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".

Example 2:

Input: s = "applepenapple", wordDict = ["apple", "pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.

Example 3:

Input: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
Output: false
=end

require 'rspec/autorun'
require 'set'

def word_break(s, word_dict)
  return false if s.nil? || s.empty? || word_dict.nil? || word_dict.empty?

  dict = Set.new
  word_dict.each { |word| dict.add word }
  dp = Array.new(s.size + 1, false)
  dp[0] = true

  1.upto(s.size) do |i|
    (i-1).downto(0) do |j|
      # puts "#{i}, #{j}, #{s[j..(i-1)]}, dp[#{j}]=#{dp[j]}"
      if dp[j] && dict.include?(s[j..(i - 1)])
        dp[i] = true
        break
      end
    end
  end
  dp[-1]
end

RSpec.describe '#word_break' do
  let(:dict1) { %w[leet code] }
  let(:dict2) { ['a', 'aa', 'aaa', 'aaaa', 'aaaaa', 'aaaaaa', 'aaaaaaa', 'aaaaaaaa', 'aaaaaaaaa', 'aaaaaaaaaa'] }
  let(:str2) { 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab' }
  let(:dict3) { %w[cats dog sand and cat] }
  let(:str3) { 'catsandog' }
  let(:dict4) { %w[a b] }
  let(:str4) { 'ab' }

  describe '#word_break' do
    it 'solves example 1' do
      expect(word_break('leetcode', dict1)).to eq(true)
    end

    it 'solves example 2' do
      expect(word_break(str2, dict2)).to eq(false)
    end

    it 'solves example 3' do
      expect(word_break(str3, dict3)).to eq(false)
    end

    it 'solves example 4' do
      expect(word_break(str4, dict4)).to eq(true)
    end
  end
end
