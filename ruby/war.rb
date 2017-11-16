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
  ROUND_STATUS_OK  = 0
  ROUND_STATUS_TIE = 1
  ROUND_STATUS_NOPOT = 3

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
    # return [nil, ROUND_STATUS_NOPOT] if @pot.empty?
    # If the pot is empty that means there was a tie in the
    # previous round and two or more hands have run out of
    # cards.  In this case the winner will be selected
    # randomly from the players with empty hands.
    if @pot.empty?
      set = @hands.select { |_, hand| hand.size == 0 }
      winner = set.keys.sample
      return [winner, ROUND_STATUS_NOPOT]
    end

    # winner = winners[Random.rand(winners.size).round].owner
    # winners = @pot.group_by { |card| card.value }.max.last
    winners = @pot.group_by(&:value).max.last

    if winners.size == 1
      return [winners.first.owner, ROUND_STATUS_OK]
    else
      return [nil, ROUND_STATUS_TIE]
    end
  end

  def award_pot_to(player)
    awarded = @pot.size
    @pot.each do |card|
      card.owner = player
    end
    @hands[player] += @pot
    @pot.clear
    awarded
  end

  def remove_empty_hands
    @hands.delete_if { |_, hand| hand.empty? }
  end

  # Unused. Considered breaking this out but uncomfortable with the
  # increased cyclomatic complexity of play_round given the indirect
  # recursion that would result.
  def break_tie
    stash = @pot.dup
    @pot.clear
    round_winner, round_awarded = play_round
    @pot.push(*stash)
    [round_winner, round_awarded]
  end

  def play_round
    awarded = 0
    play_into_pot
    winner, err = find_round_winner
    if err == ROUND_STATUS_TIE
      # break ties by recursive call after stashing the pot
      stash = @pot.dup
      @pot.clear
      round_winner, round_awarded = play_round
      @pot.push(*stash)
      awarded += round_awarded
      winner = round_winner
    end
    debug "round winner = #{winner}"
    awarded += award_pot_to winner
    @hands.each do |owner, hand|
      hand.shuffle! # shuffle to prevent cylces
      debug ">>> #{owner} has #{hand.size} cards"
    end
    remove_empty_hands unless err == ROUND_STATUS_NOPOT
    [winner, awarded]
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
