#!/usr/bin/env ruby
# frozen_string_literal: true

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
