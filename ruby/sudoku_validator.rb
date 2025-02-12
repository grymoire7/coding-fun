# Compnay interview question. Given a Sudoku board 2D array of Integer,
# determine if the board is valid.
require 'rspec/autorun'

# @param {Integer[][]} board
# @return {Boolean}
def valid_board?(board)
  return false unless valid_size?(board)

  dim = board.size
  block_size = Integer(Math.sqrt(dim))

  # create a hash of sets
  sets = Hash.new { |h, k| h[k] = Set.new }
  board.each_with_index do |row, i|
    row.each_with_index do |val, j|
      sets["r#{i}"].add val
      sets["c#{j}"].add val
      subblock = "#{i / block_size}#{j / block_size}"
      sets["q#{subblock}"].add val
      # puts "#{i}, #{j}: #{val}"
    end
    # not required, but this line will let us fail a little faster in many cases
    # if we do this, then the rows set need not be in sets{} to be checked again
    return false unless sets["r#{i}"].size == dim
  end

  valid_sets?(sets, dim)
end

def valid_sets?(sets, dim)
  # The following line works but would not return early.
  # sets.values.map { |s| s.size == dim }.reduce(true) { |ans, elm| ans && elm }
  sets.each_value do |set|
    return false unless set.size == dim
  end
  true
end

def valid_size?(board)
  return false if board.nil?

  dim = row_num = board.size
  col_num = board[0].size
  block_size = Integer(Math.sqrt(dim))
  row_num == col_num && block_size * block_size == dim
end

RSpec.describe '#valid_board?' do
  let(:valid_board) do
    [
      [4, 8, 3, 9, 2, 1, 6, 5, 7],
      [9, 6, 7, 3, 4, 5, 8, 2, 1],
      [2, 5, 1, 8, 7, 6, 4, 9, 3],
      [5, 4, 8, 1, 3, 2, 9, 7, 6],
      [7, 2, 9, 5, 6, 4, 1, 3, 8],
      [1, 3, 6, 7, 9, 8, 2, 4, 5],
      [3, 7, 2, 6, 8, 9, 5, 1, 4],
      [8, 1, 4, 2, 5, 3, 7, 6, 9],
      [6, 9, 5, 4, 1, 7, 3, 8, 2]
    ]
  end

  let(:invalid_row) do
    [
      [9, 8, 3, 9, 2, 1, 6, 5, 7], # swap [0,0] w/ [1,0]
      [4, 6, 7, 3, 4, 5, 8, 2, 1],
      [2, 5, 1, 8, 7, 6, 4, 9, 3],
      [5, 4, 8, 1, 3, 2, 9, 7, 6],
      [7, 2, 9, 5, 6, 4, 1, 3, 8],
      [1, 3, 6, 7, 9, 8, 2, 4, 5],
      [3, 7, 2, 6, 8, 9, 5, 1, 4],
      [8, 1, 4, 2, 5, 3, 7, 6, 9],
      [6, 9, 5, 4, 1, 7, 3, 8, 2]
    ]
  end

  let(:invalid_column) do
    [
      [8, 4, 3, 9, 2, 1, 6, 5, 7], # swapped [0,0] w/ [0,1]
      [9, 6, 7, 3, 4, 5, 8, 2, 1],
      [2, 5, 1, 8, 7, 6, 4, 9, 3],
      [5, 4, 8, 1, 3, 2, 9, 7, 6],
      [7, 2, 9, 5, 6, 4, 1, 3, 8],
      [1, 3, 6, 7, 9, 8, 2, 4, 5],
      [3, 7, 2, 6, 8, 9, 5, 1, 4],
      [8, 1, 4, 2, 5, 3, 7, 6, 9],
      [6, 9, 5, 4, 1, 7, 3, 8, 2]
    ]
  end

  let(:invalid_quadrant) do
    [
      [8, 4, 3, 9, 2, 1, 6, 5, 7],
      [9, 6, 7, 3, 4, 5, 8, 2, 1],
      [5, 4, 8, 1, 3, 2, 9, 7, 6], # switched these
      [2, 5, 1, 8, 7, 6, 4, 9, 3], # two rows
      [7, 2, 9, 5, 6, 4, 1, 3, 8],
      [1, 3, 6, 7, 9, 8, 2, 4, 5],
      [3, 7, 2, 6, 8, 9, 5, 1, 4],
      [8, 1, 4, 2, 5, 3, 7, 6, 9],
      [6, 9, 5, 4, 1, 7, 3, 8, 2]
    ]
  end

  describe '#valid_board?' do
    it 'recognizes a valid board' do
      expect(valid_board?(valid_board)).to eq(true)
    end

    it 'recognizes an invalid row' do
      expect(valid_board?(invalid_row)).to eq(false)
    end

    it 'recognizes an invalid column' do
      expect(valid_board?(invalid_column)).to eq(false)
    end

    it 'recognizes an invalid quadrant' do
      expect(valid_board?(invalid_column)).to eq(false)
    end

    it 'return false for a non-square board' do
      expect(valid_board?([[0, 1], [2, 3], [4, 5]])).to eq(false)
    end
  end
end
