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

  def moved_indices(deck)
    deck.cards.map { |c| reference.index(c) }
  end

  private

  # Calculate a difference array of card indexes before and after the shuffle.
  # dF_i = F_{i+1} - F_i
  # if dF_i is negative then add deck.size
  def difference_array(deck)
    a =  moved_indices(deck)
    b = a.zip(a.rotate).map { |x, y| (y - x).positive? ? (y - x) : (deck.size + y - x) }
    b
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
end
