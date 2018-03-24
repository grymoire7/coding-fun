#!/usr/bin/env ruby

class TwelveDays
  def recite
    (1..12).map {|i|
      verse(i)
    }.join("\n")
  end

  private

  ORDINALS = %w(zeroth first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
  LINES = [
        "Twelve drummers drumming",
        "Eleven pipers piping",
        "Ten lords a-leaping",
        "Nine ladies dancing",
        "Eight maids a-milking",
        "Seven swans a-swimming",
        "Six geese a-laying",
        "Five gold rings",
        "Four colly birds",
        "Three french hens",
        "Two turtle doves, and",
        "A partridge in a pear tree" ]

  def verse(i)
    "On the %s day of christmas my true love sent to me\n" % ORDINALS[i] +
      LINES.last(i).join("\n") + "\n"
  end
end

if $PROGRAM_NAME == __FILE__
  puts TwelveDays.new.recite
end
