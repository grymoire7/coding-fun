require 'spec_helper'

RSpec.describe Die do
  describe '#initialize' do
    it 'takes nothing and returns a Die object' do
      expect(Die.new).to be_an_instance_of Die
    end
  end
end

RSpec.describe Player do
  let(:name) {'player_name'}
  let(:chip_count) { rand(1..10) }
  let(:player) { Player.new(name, chip_count) }
  let(:other_player) { Player.new('anything', 0) }

  describe '#new' do
    it 'takes name and chip count and returns a Player object' do
      expect(player).to be_an_instance_of Player
    end

    it 'has the right number of chips' do
      expect(player.chip_count).to eq(chip_count)
    end

    it 'has the right name' do
      expect(player.name).to eq(name)
    end
  end

  describe '#has_chips?' do
    it 'has chips' do
      expect(player.has_chips?).to be_truthy
    end

    it 'has no chips' do
      player.chip_count = 0
      expect(player.has_chips?).to be_falsey
    end
  end

  describe '#transfer_chip_to' do
    it 'can transfer chips' do
      player.transfer_chip_to(other_player)
      expect(player.chip_count).to eq(chip_count - 1)
      expect(other_player.chip_count).to eq(1)
    end
  end

  describe '#roll' do
    it 'rolls three die' do
      expect(player.roll.size).to eq(3)
    end
  end
end

RSpec.describe LeftCenterRight do
  let(:names) { %w[Alice Bob Charlie Donna] }
  let(:starting_chips) {5}
  let!(:lcr) { LeftCenterRight.new(starting_chips, *names) }

  describe '#initialize' do
    it 'all player chip counts should be the starting chip count' do
      lcr.players.each do |p|
        expect(p.chip_count).to eq(starting_chips)
      end
    end

    it 'takes an array of player names and returns a LeftCenterRight object' do
      expect(lcr).to be_an_instance_of LeftCenterRight
    end

    it 'raises an error with less than two players' do
      expect { LeftCenterRight.new(5) }.to raise_error(RuntimeError, /two players/)
    end

    it 'raises an error with less than one chip' do
      expect { LeftCenterRight.new(0, 'a', 'b') }.to raise_error(RuntimeError, /one chip/)
    end

    it 'has the right number of players' do
      expect(lcr.players.size).to eq(names.size)
    end

    it 'creates an array of players with the given names' do
      expect(lcr.players.map {|p| p.name}).to include(*names)
     end
  end

  describe '#play' do
    # It might be better #play to return a final game state and test against
    # that.
    before { lcr.play }

    it 'has only one player with non-zero chip count' do
      expect(lcr.send(:game_over?)).to be_truthy
    end

    it 'reports a winner' do
      expect(lcr.send(:winner)).to_not be(nil)
    end
  end
end
