# frozen_string_literal: true

# Calculate the area of an n-interesting polygon.
#
class IPolyArea
  def self.area(n)
    return 0 if n <= 0

    a = 1
    (1..n).each do |i|
      a += 4 * (i - 1)
    end
    a
  end
end
