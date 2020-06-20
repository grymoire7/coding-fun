# frozen_string_literal: true

=begin
# Edit Distance

Source: https://www.geeksforgeeks.org/check-if-two-given-strings-are-at-edit-distance-one/

## Description
An edit between two strings is one of the following changes.

* Add a character
* Delete a character
* Change a character

Given two string s1 and s2, find if s1 can be converted to s2 with exactly one
edit. Expected time complexity is O(m+n) where m and n are lengths of two
strings.

### Examples:

Input:  s1 = "geeks", s2 = "geek"
Output: yes
Number of edits is 1

Input:  s1 = "geeks", s2 = "geeks"
Output: no
Number of edits is 0

Input:  s1 = "geaks", s2 = "geeks"
Output: yes
Number of edits is 1

Input:  s1 = "peaks", s2 = "geeks"
Output: no
Number of edits is 2

=end

require 'rspec/autorun'

# @param {String} word1
# @param {String} word2
# @return {Boolean}
def one_edit_away?(word1, word2)
  return false if word1.nil? || word2.nil?

  m = word1.size
  n = word2.size

  return false if (m - n).abs > 1

  diff_count = 0
  i = j = 0

  while i < m && j < n
    if word1[i] != word2[j]
      return false if diff_count == 1

      if m > n
        i += 1
      elsif n > m
        j += 1
      else
        i += 1
        j += 1
      end

      diff_count += 1
    else
      i += 1
      j += 1
    end
  end

  diff_count += 1 if i < m || j < n

  diff_count == 1
end

RSpec.describe '#one_edit_away?' do
  describe '#one_edit_away?' do
    it 'solves example 1' do
      expect(one_edit_away?('geeks', 'geek')).to eq(true)
    end

    it 'solves example 2' do
      expect(one_edit_away?('fred', 'fred')).to eq(false)
    end

    it 'solves example 3' do
      expect(one_edit_away?('howard', 'hobard')).to eq(true)
    end

    it 'solves example 4' do
      expect(one_edit_away?('gesek', 'geek')).to eq(true)
    end

    it 'handles nil strings' do
      expect(one_edit_away?(nil, nil)).to eq(false)
    end
  end
end
