# A string is said to be beautiful if each letter in the string appears at
# most as many times as the previous letter in the alphabet within the
# string; ie: b occurs no more times than a; c occurs no more times than b; etc.
# Note that letter a has no previous letter.
#
# Given a string, check whether it is beautiful.

# This is a bit ugly, but it works. I'm sure there's a more elegant way to do this.
def solution(input_string)
  counts = input_string.chars.group_by(&:itself).transform_values(&:size)
  found_chars = counts.keys.sort.uniq
  alphabet = ('a'..'z').to_a.join
  return false unless alphabet.match?(/^#{found_chars.join}/)

  counts.values_at(*found_chars).each_cons(2).map { |a| a.first >= a.last }.all?
end

# Test cases
puts solution('bbbaacdafe') == true
puts solution('aab') == true
puts solution('bbc') == false
