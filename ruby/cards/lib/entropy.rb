# frozen_string_literal: true

require './lib/deck.rb'

class Entropy
  attr_accessor :reference

  TRIALS_FOR_AVERAGE = 3

  def initialize(reference_deck = nil)
    @reference = reference_deck || Deck.new
  end

  # Test shuffling using the Shannon entropy measure.
  # We previously tested that e > 3.0 for a single iteration but found that
  # if we ran the test often enough that the test would eventually (though
  # rarely) fail.  We now test the average of a handful of iterations.
  def average_shannon
    e = 0.0
    TRIALS_FOR_AVERAGE.times do
      shuffled = yield
      e += shannon(shuffled)
    end
    e /= TRIALS_FOR_AVERAGE
  end

  # Calculates the Shannon Entropy of a shuffled deck with respect to
  # another, reference deck.
  #
  # returns: the entropy of a shuffled deck
  # see:     http://stats.stackexchange.com/questions/78591/correlation-between-two-decks-of-cards
  def shannon(deck)
    return 0 if deck.size != reference.size || deck.size < 2

    diffs = difference_array(deck)
    histogram = relative_frequency_histogram(diffs)
    e = entropy_from_histogram(histogram)
    [0.0, e].max
  end

  private

  # Calculate a difference array of card indexes before and after the shuffle.
  def difference_array(deck)
    # TODO: refactor; create a method to return array of mapped indices
    #       then diff that array
    df = []
    (0..(deck.size - 2)).each do |index|
      ref_index1 = reference.index(deck.card_at(index))
      ref_index2 = reference.index(deck.card_at(index + 1))
      df << calc_diff(ref_index1, ref_index2, deck.size)
    end

    # Diff the last card with the first card.
    ref_index1 = reference.index(deck.card_at(deck.size - 1))
    ref_index2 = reference.index(deck.card_at(0))
    df << calc_diff(ref_index1, ref_index2, deck.size)
    df
  end

  # Calculate the relative frequency of dF values in a histogram in p[].
  # This array is normalized by dividing each sum by size.  The result is
  # an array of probabilities with possible values { 0/size, 1/size, ... 1}.
  def relative_frequency_histogram(diffs)
    hist = Array.new(diffs.size, 0)
    diffs.each do |delta|
      hist[delta] += 1.0 / diffs.size
    end
    hist
  end

  # Calculate the Shannon Entropy using the differences histogram.
  def entropy_from_histogram(histogram)
    e = 0.0
    histogram.each do |p|
      e -= p * Math.log(p) if p.positive?
    end
    e
  end

  def calc_diff(index1, index2, size)
    delta = index2 - index1
    delta += size if delta.negative?
    delta
  end
end
