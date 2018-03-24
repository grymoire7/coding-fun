#!/usr/bin/env ruby

class TwelveDays
  ORDINALS = %w(zeroth first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)

  def verse(i)
    "On the %s day of christmas my true love sent to me\n" % ORDINALS[i] +
    begin
      case i
      when 1
        "A partridge in a pear tree\n"
      when 2
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 3
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 4
        "Four colly birds\n" +
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 5
        "Five gold rings\n" +
        "Four colly birds\n" +
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 6
        "Six geese a-laying\n" +
        "Five gold rings\n" +
        "Four colly birds\n" +
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 7
        "Seven swans a-swimming\n" +
        "Six geese a-laying\n" +
        "Five gold rings\n" +
        "Four colly birds\n" +
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 8
        "Eight maids a-milking\n" +
        "Seven swans a-swimming\n" +
        "Six geese a-laying\n" +
        "Five gold rings\n" +
        "Four colly birds\n" +
        "Three french hens\n" +
        "Two turtle doves, and\n" +
        "A partridge in a pear tree\n"
      when 9
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
