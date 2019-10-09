#!/usr/bin/env ruby
# frozen_string_literal: true

class Die
  def self.roll
    [:left, :center, :right, :dot, :dot, :dot].sample
  end
end

class Player
  attr_reader :name
  attr_accessor :chip_count

  def initialize(name, chip_count)
    @name = name
    @chip_count = chip_count
  end

  def has_chips?
    chip_count > 0
  end

  def transfer_chip_to(player)
    if has_chips?
      self.chip_count -= 1
      player.chip_count += 1
    end
  end

  def roll
    [ Die.roll, Die.roll, Die.roll ]
  end
end

class LeftCenterRight
  attr_reader :players, :starting_chips
  attr_accessor :pot

  # player names are specified in order of play around the table clock-wise
  def initialize(starting_chips, *player_names)
    raise 'Left-Center-Right needs at least two players!' if player_names.size < 2
    raise 'Left-Center-Right needs at least one chip!' if starting_chips < 1
    @players = player_names.map do |name|
      Player.new(name, starting_chips)
    end
    @pot = Player.new('pot', 0)       # a Player for ease of chip transfer
    @starting_chips = starting_chips
    @play_counter = 0
  end

  def play
    reset
    until game_over? do
      play_turn
    end
    puts "#{winner} wins the game in #{@play_counter} plays!"
  end

  private

  def reset
    players.each { |p| p.chip_count = starting_chips }
    @pot.chip_count = 0
    @play_counter = 0
  end

  def handle_turn_for(player)
    print "[#{@play_counter}] #{player.name} rolls:"
    player.roll.each do |roll|
      print " #{roll}"
      case roll
        when :left
          player.transfer_chip_to(players.last)
        when :center
          player.transfer_chip_to(pot)
        when :right
          player.transfer_chip_to(players[1])
      end
    end
    print "\n"
  end

  def play_turn
    @play_counter += 1
    active_player = players.first
    handle_turn_for(active_player) if active_player.has_chips?
    show_state
    players.rotate!
  end

  def winner
    players.each do |player|
      return player.name if player.has_chips?
    end
    nil
  end

  def game_over?
    players_with_chips = players.map { |p| p.has_chips? }.count(true)
    players_with_chips == 1
  end

  def show_state
    print "| "
    players.each do |player|
      print "#{player.name}: #{player.chip_count}, "
    end
    print "#{pot.name}: #{pot.chip_count}\n"
  end
end

if $PROGRAM_NAME == __FILE__
  LeftCenterRight.new(5, 'Alice', 'Bob', 'Charlie', 'Donna').play
end