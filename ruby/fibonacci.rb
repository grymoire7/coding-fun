# rubocop:disable Style/Semicolon, ParallelAssignment

# Fionacci calculates elemens of the Fibonacci sequence.
#
class Fibonacci
  def self.upto(num)
    return 0 if num <= 0

    x1, x2 = [0, 1]
    0.upto(num - 1) { x1 += x2; x1, x2 = x2, x1 }
    x1
  end

  def self.array_upto(num)
    ret = []
    return ret if num <= 0

    x1, x2 = [0, 1]
    0.upto(num - 1) { ret << x2; x1 += x2; x1, x2 = x2, x1 }
    ret
  end
end
