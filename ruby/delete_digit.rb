# frozen_string_literal: true

# Given some integer, find the maximal number you can obtain by
# deleting exactly one digit of the given number.

def delete_digit(n)
  n = n.to_s
  (0...n.size).map { |i| (n[0...i] + n[i + 1..]).to_i }.max
end

# Test cases
p delete_digit(152) => 52
p delete_digit(1001) => 101
p delete_digit(10) => 1
p delete_digit(222219) => 22229
