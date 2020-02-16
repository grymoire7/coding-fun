# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Card do
  let(:three_of_hearts) { Card.new(rank: 3, suit: :hearts) }
  let(:three_of_hearts_dup) { Card.new(rank: 3, suit: :hearts) }
  let(:four_of_hearts) { Card.new(rank: 4, suit: :hearts) }
  let(:three_of_spades) { Card.new(rank: 3, suit: :spades) }

  describe '#initialize' do
    it 'raises an error with invalid suit' do
      expect { Card.new(rank: :jack, suit: :bob) }.to raise_error(ArgumentError, /Invalid suit/)
    end
    it 'raises an error with invalid rank' do
      expect { Card.new(rank: 27, suit: :hearts) }.to raise_error(ArgumentError, /Invalid rank/)
    end
  end

  describe '#==' do
    it 'equates cards with same rank and suit' do
      expect(three_of_hearts).to eq(three_of_hearts_dup)
    end
    it 'does not equate cards with different rank and suit' do
      expect(three_of_hearts).not_to eq(four_of_hearts)
      expect(four_of_hearts).not_to eq(three_of_spades)
      expect(three_of_hearts).not_to eq(three_of_spades)
    end
  end

  describe '#to_s' do
    it 'contains rank' do
      expect(three_of_hearts.to_s).to match(/3/)
      expect(four_of_hearts.to_s).to match(/4/)
      expect(three_of_spades.to_s).to match(/3/)
    end
    it 'contains suit' do
      expect(three_of_hearts.to_s).to match(/hearts/)
      expect(four_of_hearts.to_s).to match(/hearts/)
      expect(three_of_spades.to_s).to match(/spades/)
    end
  end
end
