#!/usr/bin/env ruby

class TwelveDays
  ORDINALS = %w(zeroth first second third fourth sixth seventh eighth ninth tenth eleventh twelfth)

  def verse(i)
    case i
    when 1
      "On the %s day of christmas my true love sent to me\n" % "first" +
      "A partridge in a pear tree\n"
    when 2
      "On the %s day of christmas my true love sent to me\n" % "second" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 3
      "On the %s day of christmas my true love sent to me\n" % "third" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 4
      "On the %s day of christmas my true love sent to me\n" % "fourth" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 5
      "On the %s day of christmas my true love sent to me\n" % "fifth" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 6
      "On the %s day of christmas my true love sent to me\n" % "sixth" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 7
      "On the %s day of christmas my true love sent to me\n" % "seventh" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 8
      "On the %s day of christmas my true love sent to me\n" % "eighth" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 9
      "On the %s day of christmas my true love sent to me\n" % "ninth" +
      "Nine ladies dancing\n" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 10
      "On the %s day of christmas my true love sent to me\n" % "tenth" +
      "Ten lords a-leaping\n" +
      "Nine ladies dancing\n" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 11
      "On the %s day of christmas my true love sent to me\n" % "eleventh" +
      "Eleven pipers piping\n" +
      "Ten lords a-leaping\n" +
      "Nine ladies dancing\n" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 12
      "On the %s day of christmas my true love sent to me\n" % "twelfth" +
      "Twelve drummers drumming\n" +
      "Eleven pipers piping\n" +
      "Ten lords a-leaping\n" +
      "Nine ladies dancing\n" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    end
  end

  def recite
    (1..12).map {|i|
      verse(i)
    }.join("\n")
  end
end

if $PROGRAM_NAME == __FILE__
  puts TwelveDays.new.recite
end
