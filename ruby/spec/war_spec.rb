require 'spec_helper'

RSpec.describe War do
  before do
    @war = War.new('Alice', 'Bob')
  end

  describe '#new' do
    it 'takes an array of player names and returns a War object' do
      expect(@war).to be_an_instance_of War
    end
  end
end

