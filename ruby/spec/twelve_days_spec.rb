require 'spec_helper'

RSpec.describe TwelveDays do
  let!(:lyrics) {
    <<~EOLYRICS
      On the twelth day of christmas my true love sent to me
      Twelve drummers drumming
      Eleven pipers piping
      Ten lords a-leaping
      Nine ladies dancing
      Eight maids a-milking
      Seven swans a-swimming
      Six geese a-laying
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree
    EOLYRICS
  }

  describe '#recite' do
    it 'should recite the whole song' do
      expect(subject.recite).to eq(lyrics)
    end
  end
end
