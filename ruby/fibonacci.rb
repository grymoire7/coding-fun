# rubocop:disable Style/Semicolon, ParallelAssignment

# Fionacci calculates elemens of the Fibonacci sequence.
#
class Fibonacci
  def self.upto(n)
    return 0 if n <= 0
    x1, x2 = [0, 1]
    0.upto(n - 1) { x1 += x2; x1, x2 = x2, x1 }
    x1
  end

  def self.array_upto(n)
    ret = []
    return ret if n <= 0
    x1, x2 = [0, 1]
    0.upto(n - 1) { ret << x2; x1 += x2; x1, x2 = x2, x1 }
    ret
  end
end
