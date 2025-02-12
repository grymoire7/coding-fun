# frozen_string_literal: true

# This program will find the number of possible moves a knight can make on a
# chess board from a given starting position.
#

def knight_moves(cell)
  # Convert the cell to an array of x and y coordinates
  x = cell[0].ord - 96
  y = cell[1].to_i

  # Possible moves for the knight
  moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  in_range = ->(dx, dy) { (1..8).cover?(x + dx) && (1..8).cover?(y + dy) }

  # Count the number of possible moves
  moves.count { |move| in_range.call(*move) }
end

# Test cases
# 8 . . . . . . . .
# 7 . . . . . . . .
# 6 . . . . . . . .
# 5 . . . . . . . .
# 4 . . . . . . . .
# 3 . . . . . . . .
# 2 . . . . . . . .
# 1 . . . . . . . .
#   a b c d e f g h

p knight_moves('a1') => 2
p knight_moves('c2') => 6
p knight_moves('d4') => 8
