# Roman numeral converter
class Roman
  PLACES = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I']
  ].freeze

  def self.roman_for(number)
    return '' if number.zero?

    ''.tap do |result|
      PLACES.each do |rule|
        current_tens, current_place = rule
        val, number = number.divmod(current_tens)
        # puts "for #{number}: rule:#{rule}, #{val}, #{number}"
        next if val.zero?
        result << current_place * val
        break
      end
      return result << Roman.roman_for(number)
    end
  end

  def self.int_for(s)
    return 0 if s.nil? || s.empty?

    result = 0

    PLACES.each do |rule|
      current_tens, current_place = rule
      # puts "#{current_place}, #{s}, #{result}"
      while s.start_with?(current_place)
        s = s[current_place.size..-1]
        result += current_tens
      end
    end

    result
  end
end
