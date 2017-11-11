#!/usr/bin/env ruby

# Palindrome tester
#
class Palindrome
  def self.palindrome?(input)
    normalized = input.downcase.gsub(/\s+/, '').gsub(/\W+/, '')
    normalized == normalized.reverse
  end
end
