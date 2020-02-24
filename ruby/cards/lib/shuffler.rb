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
    # 1 and 20% of the original stock size is shuffled off each time
    max_to_shift = [1, 20 * right_hand.size / 100].max

    until right_hand.empty?
      number_to_draw = [right_hand.size, rand(1..max_to_shift)].min
      clump = right_hand.draw_from_top(number_to_draw)
      deck.add_to_top(clump)
    end
    deck
  end

  def self.cut_here(deck)
    # binomial split; previously, rand(21..31)
    Array.new(deck.size) { rand(0..1) }.sum
  end

  def self.riffle(deck)
    # split deck near the center
    cards_to_cut = cut_here(deck)
    left = deck.draw_from_top(cards_to_cut)
    right = deck.draw_from_top(deck.size)

    # randomly choose a side to drop first
    # sides = [left, right]
    # side_a = sides.delete(sides.sample)
    # side_b = sides.delete(sides.sample)

    # riffle together
    while !left.empty? || !right.empty?
      # mixprob = 0.285
      # deck.add_to_top(left.pop) if rand < mixprob
      # deck.add_to_top(right.pop) if rand < mixprob

      drop_left = rand < (left.size.to_f / (left.size + right.size))
      if drop_left
        deck.add_to_top(left.pop)
      else
        deck.add_to_top(right.pop)
      end
    end
    deck
  end

  def self.old_riffle(deck)
    # split deck near the center
    cards_to_cut = cut_here(deck)
    left = deck.draw_from_top(cards_to_cut)
    right = deck.draw_from_top(deck.size)

    # randomly choose a side to drop first
    sides = [left, right]
    side_a = sides.delete(sides.sample)
    side_b = sides.delete(sides.sample)

    # riffle together
    while !side_a.empty? || !side_b.empty?
      clump = side_a.pop([rand(1..7), side_a.size].min)
      deck.add_to_top(clump)
      clump = side_b.pop([rand(1..7), side_b.size].min)
      deck.add_to_top(clump)
    end
    deck
  end

  def self.imperfect_faro(deck)
    # split deck near the center
    cards_to_cut = cut_here(deck)
    left = deck.draw_from_top(cards_to_cut)
    right = deck.draw_from_top(deck.size)

    # randomly choose in/out faro
    sides = [left, right]
    side_a = sides.delete(sides.sample)
    side_b = sides.delete(sides.sample)

    # weave together
    while !side_a.empty? || !side_b.empty?
      cards_to_drop = rand < 0.91 ? 1 : 2
      clump = side_a.pop([cards_to_drop, side_a.size].min)
      deck.add_to_top(clump)

      cards_to_drop = rand < 0.91 ? 1 : 2
      clump = side_b.pop([cards_to_drop, side_b.size].min)
      deck.add_to_top(clump)
    end
    deck
  end

  def self.out_faro(deck)
    # split at center, use perfect weave
    cards_to_cut = deck.size / 2
    cards_to_drop = 1

    # pick a side
    side_b = deck.draw_from_top(cards_to_cut)
    side_a = deck.draw_from_top(deck.size)

    # weave together
    while !side_a.empty? || !side_b.empty?
      clump = side_a.pop([cards_to_drop, side_a.size].min)
      deck.add_to_top(clump)

      clump = side_b.pop([cards_to_drop, side_b.size].min)
      deck.add_to_top(clump)
    end
    deck
  end

  def self.in_faro(deck)
    # split at center, use perfect weave
    cards_to_cut = deck.size / 2
    cards_to_drop = 1

    # pick a side
    side_a = deck.draw_from_top(cards_to_cut)
    side_b = deck.draw_from_top(deck.size)

    # weave together
    while !side_a.empty? || !side_b.empty?
      clump = side_a.pop([cards_to_drop, side_a.size].min)
      deck.add_to_top(clump)

      clump = side_b.pop([cards_to_drop, side_b.size].min)
      deck.add_to_top(clump)
    end
    deck
  end
end
