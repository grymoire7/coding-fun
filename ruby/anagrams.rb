# Given an array of strings, group anagrams together.
# Example:
# Input: ['eat', 'ate', 'apt', 'pat', 'tea', 'now']
# Output: [['eat', 'ate', 'tea'], ['apt', 'pat'], ['now']]
#

def anagram(input)
  groups = Hash.new { |h, k| h[k] = [] }
  input.each { |word| groups[word.chars.sort.join] << word }
  groups.values
end

g = anagram %w[eat ate apt pat tea now]
puts g.inspect
