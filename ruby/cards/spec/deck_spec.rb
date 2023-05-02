# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Deck do
  let(:deck) { Deck.new }
  let(:deck_jokers) { Deck.new(include_jokers: true) }
  let(:deck_empty) { Deck.new(empty: true) }

  describe '#initialize' do
    it 'creates a deck with 52 cards by default' do
      expect(deck.size).to eq(52)
    end
    it 'creates a deck with 54 cards with jokers' do
      expect(deck_jokers.size).to eq(54)
    end
    it 'has 2 jokers in a deck with jokers' do
      expect(deck_jokers.count { |c| c.suit == :jokers }).to eq(2)
    end
    it 'creates a deck with 0 cards when empty' do
      expect(deck_empty.size).to eq(0)
    end
  end

  describe '#clear' do
    it 'removes all cards from the deck' do
      expect(Deck.new.clear.size).to eq(0)
    end
  end

  describe '#==' do
    it 'equates decks with same cards in same positions' do
      deck_a = Deck.new
      deck_b = Deck.new
      expect(deck_a).to eq(deck_b)
    end
    it 'equates empty decks' do
      deck_a = Deck.new(empty: true)
      deck_b = Deck.new(empty: true)
      expect(deck_a).to eq(deck_b)
    end
    it 'does not equate decks cards in different order' do
      deck_a = Deck.new
      deck_b = Deck.new.shuffle!
      expect(deck_a).not_to eq(deck_b)
    end
  end

  describe '#draw_from_top' do
    it 'draws the ace of hearts in a new deck' do
      expect(deck.draw_from_top).to eq(Card.new rank: :ace, suit: :hearts)
      expect(deck.size).to eq(51)
    end
  end

  describe '#draw_from_bottom' do
    it 'draws the ace of spades in a new deck' do
      expect(deck.draw_from_bottom).to eq(Card.new(rank: :ace, suit: :spades))
      expect(deck.size).to eq(51)
    end
  end

  describe '#add_to_top' do
    it 'adds cards to the top' do
      kh = Card.new rank: :king, suit: :hearts
      deck.add_to_top(kh)
      expect(deck.size).to eq(53)
      expect(deck.draw_from_top).to eq(kh)
    end
  end

  describe '#add_to_bottom' do
    it 'adds cards to the bottom' do
      kh = Card.new rank: :king, suit: :hearts
      deck.add_to_bottom(kh)
      expect(deck.size).to eq(53)
      expect(deck.draw_from_bottom).to eq(kh)
    end
  end

  describe '#has?' do
    it 'finds cards that are in the deck' do
      expect(deck.has?(rank: :ace, suit: :hearts)).to be_truthy
    end
    it 'does not find cards that are not in the deck' do
      deck.draw_from_top
      expect(deck.has?(rank: :ace, suit: :hearts)).to be_falsey
    end
  end

  describe '#draw' do
    it 'draws the ace of hearts from a new deck' do
      expect(deck.draw(rank: :ace, suit: :hearts)).to eq(Card.new(rank: :ace, suit: :hearts))
      expect(deck.size).to eq(51)
    end
  end
end
