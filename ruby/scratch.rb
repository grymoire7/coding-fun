s = 'aaabbcaaddddc'
s.chars.chunk(&:itself).map { |k, v| v.size > 1 ? "#{v.size}#{k}" : k }.join
# => "3a2bc2a4dc"

s = '12 apples, 3 oranges'
s.chars.chunk { |c| c.match?(/[[:digit:]]/) }.select{|b,_| b}.map{|a| a.last.join.to_i}.sum
s.scan(/\d+/).map(&:to_i)

# You are taking part in an Escape Room challenge designed specifically
# for programmers. In your efforts to find a clue, you’ve found a
# binary code written on the wall behind a vase, and realized that
# it must be an encrypted message. After some thought, your first
# guess is that each consecutive 8 bits of the code stand for the
# character with the corresponding extended ASCII code.
#
# Assuming that your hunch is correct, decode the message.
#
# Example:
# For code = "010010000110010101101100011011000110111100100001", the output should be
# messageFromBinaryCode(code) = "Hello!".

def message_from_binary(code)
  code.chars.each_slice(8).map { |ba| ba.join.to_i(2).chr }.join
end
