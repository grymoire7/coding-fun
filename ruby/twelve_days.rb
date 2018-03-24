#!/usr/bin/env ruby

class TwelveDays
  def verse(i)
    case i
    when 1
      "On the first day of christmas my true love sent to me\n" +
      "A partridge in a pear tree\n"
    when 2
      "On the second day of christmas my true love sent to me\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 3
      "On the third day of christmas my true love sent to me\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 4
      "On the fourth day of christmas my true love sent to me\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 5
      "On the fifth day of christmas my true love sent to me\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 6
      "On the sixth day of christmas my true love sent to me\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 7
      "On the seventh day of christmas my true love sent to me\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 8
      "On the eighth day of christmas my true love sent to me\n" +
      "Eight maids a-milking\n" +
      "Seven swans a-swimming\n" +
      "Six geese a-laying\n" +
      "Five gold rings\n" +
      "Four colly birds\n" +
      "Three french hens\n" +
      "Two turtle doves, and\n" +
      "A partridge in a pear tree\n"
    when 9
      "On the ninth day of christmas my true love sent to me\n" +
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
      "On the tenth day of christmas my true love sent to me\n" +
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
      "On the eleventh day of christmas my true love sent to me\n" +
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
      "On the twelfth day of christmas my true love sent to me\n" +
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
