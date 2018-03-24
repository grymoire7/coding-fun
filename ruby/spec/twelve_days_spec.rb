require 'spec_helper'

RSpec.describe TwelveDays do
  let!(:lyrics) {
    <<~EOLYRICS
      On the first day of christmas my true love sent to me
      A partridge in a pear tree

      On the second day of christmas my true love sent to me
      Two turtle doves, and
      A partridge in a pear tree

      On the third day of christmas my true love sent to me
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the fourth day of christmas my true love sent to me
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the fifth day of christmas my true love sent to me
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the sixth day of christmas my true love sent to me
      Six geese a-laying
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the seventh day of christmas my true love sent to me
      Seven swans a-swimming
      Six geese a-laying
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the eighth day of christmas my true love sent to me
      Eight maids a-milking
      Seven swans a-swimming
      Six geese a-laying
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the ninth day of christmas my true love sent to me
      Nine ladies dancing
      Eight maids a-milking
      Seven swans a-swimming
      Six geese a-laying
      Five gold rings
      Four colly birds
      Three french hens
      Two turtle doves, and
      A partridge in a pear tree

      On the tenth day of christmas my true love sent to me
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

      On the eleventh day of christmas my true love sent to me
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

      On the twelfth day of christmas my true love sent to me
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
