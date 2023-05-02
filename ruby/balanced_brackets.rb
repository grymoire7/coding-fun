# frozen_string_literal: true

=begin
# Balanced Brackets
* https://www.hackerrank.com/challenges/balanced-brackets/problem
* https://leetcode.com/problems/valid-parentheses/

## Description
Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.

Note that an empty string is also considered valid.

Example 1:

Input: "()"
Output: true

Example 2:

Input: "()[]{}"
Output: true

Example 3:

Input: "(]"
Output: false

Example 4:

Input: "([)]"
Output: false

Example 5:

Input: "{[]}"
Output: true
=end

require 'rspec/autorun'

# @param {String} str
# @return {Boolean}
def is_valid(str)
  return true if str.nil? || str.empty?

  parens = { '(' => ')', '[' => ']', '{' => '}' }
  stack = []

  str.chars.each do |c|
    if parens.keys.include? c
      stack.push c
    elsif parens.values.include? c
      return false unless !stack.empty? && (parens[stack[-1]] == c)

      stack.pop
    # else not a paren we care about
    end
  end

  stack.empty?
end

RSpec.describe '#is_valid' do
  describe '#has_cycle' do
    it 'solves example 1' do
      expect(is_valid('{[]}')).to eq(true)
    end

    it 'solves example 2' do
      expect(is_valid('([)]')).to eq(false)
    end

    it 'solves example 3' do
      expect(is_valid('([')).to eq(false)
    end

    it 'handles empty array' do
      expect(is_valid(nil)).to eq(false)
    end
  end
end
