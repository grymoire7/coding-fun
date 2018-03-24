#!/usr/bin/env ruby

class TwelveDays
  def recite
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
  end
end

if $PROGRAM_NAME == __FILE__
  puts TwelveDays.new.recite
end
