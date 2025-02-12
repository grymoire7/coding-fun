# Given a rectangular matrix containing only digits, calculate the number of different 2 × 2 squares in it.
#
# Example:
#
# matrix = [[1, 2, 1],
#           [2, 2, 2],
#           [2, 2, 2],
#           [1, 2, 3],
#           [2, 2, 1]]
#
# The output should be
# differentSquares(matrix) = 6.

def different_squares(matrix)
  squares = {}
  (0..matrix.size - 2).each do |i|
    (0..matrix[0].size - 2).each do |j|
      square = []
      square << matrix[i][j]
      square << matrix[i + 1][j]
      square << matrix[i][j + 1]
      square << matrix[i + 1][j + 1]
      squares[square] = true
    end
  end
  squares.size
end

def different_squares_orig(matrix)
  squares = []
  (0..matrix.size - 2).each do |i|
    (0..matrix[0].size - 2).each do |j|
      square = []
      (0..1).each do |k|
        (0..1).each do |l|
          square << matrix[i + k][j + l]
        end
      end
      squares << square
    end
  end
  squares.uniq.size
end

# Test cases
p different_squares([[1, 2, 1], [2, 2, 2], [2, 2, 2], [1, 2, 3], [2, 2, 1]]) => 6
