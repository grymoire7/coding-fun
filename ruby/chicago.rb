#!/usr/bin/env ruby
# frozen_string_literal: true

# Chicago – Dice Game
# Number of players: 2 or more
# Number of dice: 2
#
# The Chicago dice game is a simple yet fun game. The rules are not very difficult 
# and the game is decided by pure luck, but still it is very addictive. Once you 
# start you might not want to stop to see if you can do better in the next game.
#
# The game is played in 11 rounds, starting with round 2, then going to round 3 
# and continuing until round 12. In each round each player takes his or her turn 
# and rolls both dice, trying to roll the number of that round. For example, in 
# the round with number 2, you aim to roll a 1 on each dice giving you a total of 2.
#
# Every player that rolls the number of the current round gets a point and adds 
# it to his overall score. After all 11 rounds are finished the game ends and the 
# player with the higher number of points is declared the winner.

class Die
  def self.roll
    rand(1..6)
  end
end

class Player
  attr_reader :dice_count, :name

  def initialize(name, dice_count)
    @name = name
    @dice_count = dice_count
  end

  def roll
    total = 0
    dice_count.times do
      total += Die.roll
    end
    total
  end
end

class Chicago
  attr_reader :players, :scores

  def initialize(*player_names)
    raise 'Chicago needs at least two players!' if player_names.size < 2
    @players = player_names.map do |name|
      Player.new(name, 2)
    end
    @scores = Hash[player_names.zip([0] * player_names.size)]
  end

  def reset
    scores.each_key { |k| scores[k] = 0 }
  end

  def play_round(n)
    players.each do |player|
      # Play
      total_roll = player.roll
      print "#{n}: #{player.name} rolls #{total_roll}"
      # Score
      if total_roll == n
        scores[player.name] = scores[player.name] + 1
        print ' *'
      end
      print "\n"
    end
  end

  def play
    (2..12).each do |round|
      play_round(round)
    end
  end

  def show_results
    players.each do |player|
      puts "| #{player.name} has #{scores[player.name]} points"
    end
    winners, high_score = find_winners
    verb = winners.size > 1 ? 'tie' : 'wins'
    puts "> #{winners.join(' and ')} #{verb} with a score of #{high_score}"
  end

  private

  def find_winners
    high_score = scores.values.max
    winners = []
    players.each do |player|
      winners << player.name if scores[player.name] == high_score
    end
    [winners, high_score]
  end
end

if $PROGRAM_NAME == __FILE__
  game = Chicago.new('Alice', 'Bob', 'Charlie')
  2.times do
    game.play
    game.show_results
    game.reset
  end
end
