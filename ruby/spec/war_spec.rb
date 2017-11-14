require 'spec_helper'

RSpec.describe War do
  let(:names) { %w[Alice Bob] }
  let!(:war) { War.new(*names) }

  describe '#deal' do
    before :each do
      war.deal
    end
    it 'should deal 52 cards equally' do
      total = 0
      war.hands.each_value do |hand|
        expect(hand.size).to eq(26)
        total += hand.size
      end
      expect(total).to eq(52)
    end
    it 'deals all cards exactly once' do
      deck = []
      war.hands.each_value do |hand|
        hand.each do |card|
          deck << card.value
        end
      end
      expect(deck.size).to eq(52)
      (2..14).each do |value|
        expect(deck.count(value)).to eq(4)
      end
    end
  end

  describe '#new' do
    it 'takes an array of player names and returns a War object' do
      expect(war).to be_an_instance_of War
    end
    it 'raises an error with less than two players' do
      expect { War.new }.to raise_error(RuntimeError, /two players/)
    end
    it 'creates an array of players with names and cards' do
      expect(war.players.size).to eq(2)
    end
  end

  describe '#play_into_pot' do
    before :each do
      war.deal
    end
    it 'adds one card per player' do
      war.play_into_pot
      expect(war.pot.size).to eq(2)
    end
    it 'removes a card from each player' do
      war.play_into_pot
      war.hands.each_value do |hand|
        expect(hand.size).to eq(25)
      end
    end
  end

  describe '#award_pot_to' do
    before :each do
      war.deal
      war.play_into_pot
      winner, = war.hands.first
      war.award_pot_to winner
    end
    it 'removes all cards from the pot' do
      expect(war.pot).to be_empty
    end
  end

  describe '#remove_empty_hands' do
    it 'removes empty hands' do
      war.deal
      war.hands.values[0].clear
      war.remove_empty_hands
      expect(war.hands.size).to eq(1)
    end
  end

  describe '#play' do
    it 'should return a winner' do
      expect(war.play).to be_an_instance_of Array
    end
    it 'should not be biased' do
      stats = StatsCollector.new(war)
      stats.play(1000)
      percent_win = stats.results.first[1][:percent_win]
      expect(percent_win).to be > 45
      expect(percent_win).to be < 55
    end
  end

  describe 'Card' do
    describe '#new' do
      it 'takes an owner and value and returns a Card object' do
        expect(Card.new('owner', 5)).to be_an_instance_of Card
      end
      it 'raises an error with less than two params' do
        expect { Card.new }.to raise_error(ArgumentError)
      end
      it 'raises an error bad params' do
        expect { Card.new(5, 'bob') }.to raise_error(ArgumentError)
      end
    end
  end
end
