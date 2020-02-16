# frozen_string_literal: true

require './lib/deck.rb'

class Shuffler
  def self.random(deck)
    deck.shuffle!
  end

  def self.overhand(deck)
    # Move all the cards into the right hand then
    # shuffle off into the left hand (original deck)
    right_hand = Deck.new(empty: true)
    right_hand.add_to_bottom(deck.cards)
    deck.clear

    # personal experimentation and observation reveals that betwen
    # 1 and 15% of the original stock size is shuffled off each time
    max_to_shift = [1, 15 * right_hand.size / 100].max

    while !right_hand.empty?
      number_to_draw = [right_hand.size, rand(1..max_to_shift)].min
      clump = right_hand.draw_from_top(number_to_draw)
      deck.add_to_top(clump)
    end
    deck
  end

  def self.riffle(deck)
    # split deck
    cards_to_cut = rand(21..31)
    left = deck.draw_from_top(cards_to_cut)
    right = deck.draw_from_top(deck.size)
    # riffle together
    sides = [left, right]
    side_a = sides.shuffle.pop
    side_b = sides.pop
    while side_a.size || side_b.size do
      clump = side_a.draw_from_bottom([rand(1..7), side_a.size].min)
      deck.add_to_bottom(clump)
      clump = side_b.draw_from_bottom([rand(1..7), side_b.size].min)
      deck.add_to_bottom(clump)
    end
    deck
  end
end
