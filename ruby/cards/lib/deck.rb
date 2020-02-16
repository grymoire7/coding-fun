# frozen_string_literal: true

require './lib/card.rb'

class Deck
  attr_accessor :cards

  def initialize(include_jokers: false, empty: false)
    @cards = []
    return if empty

    ranks = [:ace, *(2..10), :jack, :queen, :king]
    # suits = %i[clubs hearts spades diamonds]
    @cards = []

    # Add cards in new deck order
    ranks.each do |rank|
      @cards << Card.new(rank: rank, suit: :hearts)
    end

    ranks.each do |rank|
      @cards << Card.new(rank: rank, suit: :clubs)
    end

    ranks.reverse.each do |rank|
      @cards << Card.new(rank: rank, suit: :diamonds)
    end

    ranks.reverse.each do |rank|
      @cards << Card.new(rank: rank, suit: :spades)
    end

    if include_jokers
      @cards << Card.new(rank: :jester, suit: :jokers)
      @cards << Card.new(rank: :guarantee, suit: :jokers)
    end
  end

  def shuffle!
    @cards.shuffle!
    self
  end

  def clear
    @cards.clear
  end

  def empty?
    @cards.empty?
  end

  def draw(rank:, suit:)
    draw_card(Card.new(rank: rank, suit: suit))
  end

  def draw_card(card)
    found = []
    @cards.delete_if { |c| found << c if c == card }
    if found.size == 1
      found.first
    else
      found
    end
  end

  def draw_from_top(num = 1)
    if num == 1
      @cards.shift
    else
      @cards.shift(num)
    end
  end

  def draw_from_bottom(num = 1)
    if num == 1
      @cards.pop
    else
      @cards.pop(num)
    end
  end

  def add_to_top(card_s)
    @cards.unshift(*card_s)
  end

  def add_to_bottom(card_s)
    @cards.push(*card_s)
  end

  def index(card)
    @cards.index(card)
  end

  def card_at(index)
    @cards[index]
  end

  def select
    @cards.select { |c| yield(c) }
  end

  def count
    @cards.select { |c| yield(c) }.size
  end

  def size
    @cards.size
  end

  def has?(rank:, suit:)
    select { |c| c.rank == rank && c.suit == suit }.empty? == false
  end

  def to_s
    @cards.each { |c| puts c }
    nil
  end

  def ==(other)
    cards == other.cards
  end
end
