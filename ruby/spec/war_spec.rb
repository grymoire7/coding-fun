require 'spec_helper'

RSpec.describe War do
  let(:names) { %w[Alice Bob] }
  let(:playerA) { 'Alice' }
  let(:playerB) { 'Bob' }
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
    it 'has two players' do
      expect(war.players.size).to eq(2)
    end
    it 'creates an array of players with names' do
      expect(war.players).to include(*names)
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

  describe '#find_round_winner' do
    before :each do
      war.reset
    end
    context 'when the first player has the high card' do
      it 'declares the first player the winner' do
        war.hands[playerA] << Card.new(playerA, 7)
        war.hands[playerB] << Card.new(playerB, 6)
        war.play_into_pot
        expect(war.find_round_winner.first).to eq(playerA)
      end
    end
    context 'when the second player has the high card' do
      it 'declares the second player the winner' do
        war.hands[playerA] << Card.new(playerA, 7)
        war.hands[playerB] << Card.new(playerB, 8)
        war.play_into_pot
        expect(war.find_round_winner.first).to eq(playerB)
      end
    end
    context 'when there is a tie' do
      it 'still declares a winner' do
        war.hands[playerA] << Card.new(playerA, 3)
        war.hands[playerB] << Card.new(playerB, 3)
        war.hands[playerA] << Card.new(playerA, 4)
        war.hands[playerB] << Card.new(playerB, 4)
        war.hands[playerA] << Card.new(playerA, 5)
        war.hands[playerB] << Card.new(playerB, 6)
        # war.play_into_pot
        # expect(war.find_round_winner).to eq(playerB)
        winner, awarded = war.play_round
        expect(winner).to eq(playerB)
        expect(awarded).to eq(6)
      end
      it 'increases the pot size to find the winner' do
        war.hands[playerA] << Card.new(playerA, 3)
        war.hands[playerB] << Card.new(playerB, 3)
        war.hands[playerA] << Card.new(playerA, 4)
        war.hands[playerB] << Card.new(playerB, 4)
        war.hands[playerA] << Card.new(playerA, 5)
        war.hands[playerB] << Card.new(playerB, 6)
        winner, awarded = war.play_round
        expect(winner).to eq(playerB)
        expect(awarded).to eq(6)
      end
      it 'handles a tie game' do
        war.hands[playerA] << Card.new(playerA, 3)
        war.hands[playerB] << Card.new(playerB, 3)
        war.hands[playerA] << Card.new(playerA, 4)
        war.hands[playerB] << Card.new(playerB, 4)
        war.hands[playerA] << Card.new(playerA, 5)
        war.hands[playerB] << Card.new(playerB, 5)
        winner, awarded = war.play_round
        expect(winner).to be_truthy
        expect(awarded).to eq(6)
      end
      it 'prefers a player with cards' do
        war.hands[playerA] << Card.new(playerA, 3)
        war.hands[playerB] << Card.new(playerB, 3)
        war.hands[playerA] << Card.new(playerA, 4)
        war.hands[playerB] << Card.new(playerB, 4)
        war.hands[playerA] << Card.new(playerA, 5)
        winner, awarded = war.play_round
        expect(winner).to eq(playerA)
        expect(awarded).to eq(5)
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
