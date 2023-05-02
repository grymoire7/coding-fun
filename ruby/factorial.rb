# frozen_string_literal: true

# Factorial calculator
#
class Factorial
  def self.factorial(n)
    # p "class factorial #{n}"
    (1..n).inject(:*) || 1
  end

  def self.factorial_r(n)
    # p "class factorial_r #{n}"
    return 1 if n <= 1

    n * factorial_r(n - 1)
  end
end
