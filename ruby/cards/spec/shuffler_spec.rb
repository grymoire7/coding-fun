# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shuffler do
  let(:reference_deck) { Deck.new }
  let(:entropy) { Entropy.new }

  describe 'self.random' do
    it 'has average Shannon entropy > 3.0' do
      e = entropy.average_shannon do
        Shuffler.random Deck.new
      end
      expect(e).to be > 3.0
    end
  end

  describe 'self.riffle' do
    it 'should have the same number of cards' do
      deck = Deck.new
      deck_size = deck.size
      Shuffler.riffle deck
      expect(deck.size).to eq(deck_size)
    end

    # we expect low entropy after only a few overhand shuffles
    it 'has average Shannon entropy < 3.0 with few shuffles' do
      e = entropy.average_shannon do
        Shuffler.riffle Deck.new
      end
      expect(e).to be < 3.0
    end

    # we expect higher entropy after many overhand shuffles
    it 'has average Shannon entropy > 3.0 with many shuffles' do
      e = entropy.average_shannon do
        d = Deck.new
        50.times do
          Shuffler.riffle d
        end
        d
      end
      expect(e).to be > 3.0
    end
  end

  describe 'self.overhand' do
    # we expect low entropy after only a few overhand shuffles
    it 'has average Shannon entropy < 3.0 with few shuffles' do
      e = entropy.average_shannon do
        Shuffler.overhand Deck.new
      end
      expect(e).to be < 3.0
    end

    # we expect higher entropy after many overhand shuffles
    it 'has average Shannon entropy > 3.0 with many shuffles' do
      e = entropy.average_shannon do
        d = Deck.new
        50.times do
          Shuffler.overhand d
        end
        d
      end
      expect(e).to be > 3.0
    end
  end
end
