# frozen_string_literal: true

=begin
# Word Search
Source: https://leetcode.com/problems/word-search/

## Description
Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where
"adjacent" cells are those horizontally or vertically neighboring. The same
letter cell may not be used more than once.

Example:

board =
  [
    ['A','B','C','E'],
    ['S','F','C','S'],
    ['A','D','E','E']
  ]

Given word = "ABCCED", return true.
Given word = "SEE", return true.
Given word = "ABCB", return false.

Constraints:

board and word consists only of lowercase and uppercase English letters.
1 <= board.length <= 200
1 <= board[i].length <= 200
1 <= word.length <= 10^3

=end

require 'rspec/autorun'

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exista(board, word)
  (0..board.size - 1).each do |i|
    (0..board[0].size - 1).each do |j|
      return true if dfs(board, word, i, j)
    end
  end
  false
end

def dfs(board, word, i, j, k = 0)
  return false unless i.between?(0, board.size - 1) && j.between?(0, board[0].size - 1)

  if board[i][j] == word[k]
    return true if k == (word.size - 1)

    temp = board[i][j]
    board[i][j] = '@'

    return true if (
      dfs(board, word, i + 1, j, k + 1) ||
      dfs(board, word, i - 1, j, k + 1) ||
      dfs(board, word, i, j + 1, k + 1) ||
      dfs(board, word, i, j - 1, k + 1)
    )
    board[i][j] = temp
  end

  false
end

RSpec.describe '#exist' do
  let(:board1) do
    [
      %w[A B C E],
      %w[S F C S],
      %w[A D E E]
    ]
  end

  describe '#exist' do
    it 'solves example 1' do
      expect(exista(board1, 'SEE')).to eq(true)
    end

    it 'solves example 2' do
      expect(exista(board1, 'ABCCED')).to eq(true)
    end

    it 'solves example 3' do
      expect(exista(board1, 'ABCB')).to eq(false)
    end
  end
end
