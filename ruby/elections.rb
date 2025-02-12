# frozen_string_literal: true

# Elections are in progress!
#
# Given an array of the numbers of votes given to each of the candidates
# so far, and an integer k equal to the number of voters who haven't
# cast their vote yet, find the number of candidates who still have
# a chance to win the election.
#
# The winner of the election must secure strictly more votes than any
# other candidate. If two or more candidates receive the same (maximum)
# number of votes, assume there is no winner at all.
#

def solution(votes, k)
  vote_max = votes.max
  max_votes = votes.map { |x| x + k }.sort.reverse
  winners = max_votes.select { |v| v > vote_max }

  # If there is no candidate with more votes than the current winner
  # and there is only one candidate with the same number of votes as the
  # current winner then the current winner is the only potential winner.
  #
  # Otherwise, the potential winners are the candidates with more
  # votes than the current winner.

  return 1 if winners.empty? && max_votes.count(vote_max) == 1

  winners.size
end

puts solution([2, 3, 5, 2], 3) => 2
puts solution([1, 1, 1, 1], 1) => 4
puts solution([5, 1, 1, 1], 0) => 1
puts solution([3, 3, 1, 1], 1) => 2
puts solution([3, 2, 1, 1], 1) => 1
