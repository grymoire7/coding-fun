#!/usr/bin/env ruby

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

require 'rspec/autorun'

class Die
  def self.roll
    rand(1..6)
  end
end

# The Player class is responsible for rolling the dice and keeping track of their score.
class Player
  attr_reader :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def play(round)
    round_score = Die.roll + Die.roll
    @score += 1 if round_score == round
  end

  def reset
    @score = 0
  end
end

# The Chicago class is responsible for managing the game and the players.
class Chicago
  attr_reader :players

  def initialize(*player_names)
    raise 'Chicago needs at least two players!' if player_names.size < 2

    @players = player_names.map { |name| Player.new(name) }
  end

  # The play method runs through 11 rounds and has each player roll the dice.
  def play
    (2..12).each do |round|
      log "round: #{round}"
      players.each do |player|
        player.play(round)
        log "#{player.name} has score #{player.score}"
      end
    end
  end

  # The show_results method displays the scores of each player and the winners.
  def show_results
    players.each do |player|
      puts "#{player.name} has score #{player.score}"
    end

    puts "Winners: #{winners.map(&:name).join(', ')}"
  end

  # The winners method returns an array of the players with the highest score.
  # Exposed primarily for testing.
  def winners
    return @winners if defined? @winners

    max_score = players.max_by(&:score).score
    @winners = players.find_all { |player| player.score == max_score }
  end

  # The reset method resets the scores of all players and removes the winners.
  def reset
    players.each(&:reset)
    remove_instance_variable(:@winners) if defined? @winners
  end

  private

  # The log method is used for debugging purposes.
  def log(message)
    debug = false
    puts message if debug
  end
end

# if $PROGRAM_NAME == __FILE__
#   game = Chicago.new('Alice', 'Bob', 'Charlie')
#   2.times do
#     game.play
#     game.show_results
#     game.reset
#   end
# end

RSpec.describe 'Chicago' do
  let(:game) { Chicago.new('Alice', 'Bob', 'Charlie') }

  before(:each) do
    game.reset
  end

  context 'creating' do
    it 'creates a game with players' do
      expect(game.players.size).to eq(3)
    end
  end

  context '#play' do
    it 'populates winners' do
      srand(42)
      game.play
      expect(game.winners.size).to eq(1)
      expect(game.winners.first.score).to eq(1)
      expect(game.winners.first.name).to eq('Bob')
      expect(game.players.max_by(&:score).score).to eq(1)
    end
  end
end
