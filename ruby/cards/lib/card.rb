# frozen_string_literal: true

class Card
  attr_reader :rank, :suit
  attr_accessor :state

  def initialize(rank:, suit:)
    raise ArgumentError, 'Invalid suit' unless valid_suits.include? suit
    raise ArgumentError, 'Invalid rank' unless valid_ranks.include? rank

    @rank = rank
    @suit = suit
    @state = [ :face_down ]
  end

  def to_s
    "The #{rank} of #{suit}"
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  private

  def valid_ranks
    [:ace, *(2..10), :jack, :queen, :king, :jester, :guarantee]
  end

  def valid_suits
    %i[clubs hearts spades diamonds jokers]
  end
end
