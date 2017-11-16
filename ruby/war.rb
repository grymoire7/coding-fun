#!/usr/bin/env ruby
# rubocop:disable Style/SingleLineMethods, Style/CommentedKeyword

class Pot < Array; end
class Cards < Array; end

class Card
  attr_accessor :owner, :value

  def initialize(owner, value)
    @owner = String(owner)
    @value = Integer(value)
  end

  def to_s; "#{owner}, #{value}"; end

  def to_str; to_s; end
end

class StatsCollector
  attr_accessor :data, :players, :results

  def initialize(game)
    @game = game
    @players = game.players
    @data = []
  end

  def add_win(player, rounds)
    @data << { player => rounds }
  end

  def play(num_games)
    num_games.times do
      winner, rounds = @game.play
      add_win(winner, rounds)
    end
    collect
  end

  def collect
    @results = {}
    @players.each do |player|
      set = @data.select { |datum| datum.key? player }
      percent_win = set.size.fdiv(data.size) * 100
      rounds = set.inject(0) { |sum, datum| sum + datum[player] }
      avg_rounds = rounds.fdiv(set.size)
      @results[player] = {
        wins: set.size,
        percent_win: percent_win,
        avg_rounds: avg_rounds
      }
    end
  end

  def report
    puts "In #{@data.size} games..."
    @results.each do |player, result|
      print "#{player} won #{result[:wins]} times. "
      print format('(%.02f%%) in an average', result[:percent_win])
      puts format(' of %.02f rounds.', result[:avg_rounds])
    end
  end
end

class War
  attr_accessor :players, :hands, :pot
  DEBUG = false

  def debug(msg, obj = nil)
    msg = "== Debug: #{msg}" unless msg.class != String
    warn msg if DEBUG
    warn obj if DEBUG && !obj.nil?
  end

  def initialize(*player_names)
    raise 'war needs at least two players' if player_names.size < 2
    @players = player_names
    @pot = Pot.new
    @hands = {}
  end

  def reset
    @pot.clear
    @hands.clear
    @players.each do |player|
      @hands[player] = Cards.new
    end
  end

  def deal
    reset
    deck_values = []
    4.times { deck_values += (2..14).to_a }
    deck_values.shuffle!
    i = 0
    deck_values.each do |value|
      owner = @players[i % @players.size]
      @hands[owner] << Card.new(owner, value)
      i += 1
    end
  end

  def play_into_pot
    @hands.each_value do |cards|
      @pot << cards.shift unless cards.empty?
    end
  end

  def find_round_winner
    # TODO: handle ties by playing more hands
    # TODO: right now it chooses randomly
    # winners = @pot.group_by { |card| card.value }.max.last
    winners = @pot.group_by(&:value).max.last
    winner = winners[Random.rand(winners.size).round].owner
    winner
  end

  def award_pot_to(player)
    @pot.each do |card|
      card.owner = player
    end
    @hands[player] += @pot
    @pot.clear
  end

  def remove_empty_hands
    @hands.delete_if { |_, hand| hand.empty? }
  end

  def play_round
    play_into_pot
    winner = find_round_winner
    debug "round winner = #{winner}"
    award_pot_to winner
    @hands.each do |owner, hand|
      hand.shuffle! # shuffle to prevent cylces
      debug ">>> #{owner} has #{hand.size} cards"
    end
    remove_empty_hands
  end

  def play
    deal
    rounds = 0
    while @hands.size > 1
      play_round
      rounds += 1
    end
    winner, = @hands.first
    [winner, rounds]
  end
end

if $PROGRAM_NAME == __FILE__
  game = War.new('Alice', 'Bob')
  winner, rounds = game.play
  puts "#{winner} wins in #{rounds} rounds."

  # See if there's a bias over time.
  stats = StatsCollector.new(game)
  stats.play(1000)
  stats.report
end
