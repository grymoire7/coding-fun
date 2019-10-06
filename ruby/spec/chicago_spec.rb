require 'spec_helper'

RSpec.describe Chicago do
  let(:names) { %w[Alice Bob] }
  let(:playerA) { 'Alice' }
  let(:playerB) { 'Bob' }
  let!(:chicago) { Chicago.new(*names) }

  describe '#initialize' do
    it 'all player scores should be zero' do
      chicago.scores.each_value do |score|
        expect(score).to eq(0)
      end
    end
  end

  describe '#new' do
    it 'takes an array of player names and returns a Chicago object' do
      expect(chicago).to be_an_instance_of Chicago
    end
    it 'raises an error with less than two players' do
      expect { Chicago.new }.to raise_error(RuntimeError, /two players/)
    end
    it 'all player scores should be zero' do
      chicago.scores.each_value do |score|
        expect(score).to eq(0)
      end
    end
    it 'has two players' do
      expect(chicago.players.size).to eq(2)
    end
    it 'creates an array of players with names' do
      expect(chicago.players.map {|p| p.name}).to include(*names)
     end
  end

  describe 'Die' do
    describe '#new' do
      it 'takes nothing and returns a Die object' do
        expect(Die.new).to be_an_instance_of Die
      end
    end
  end
end
