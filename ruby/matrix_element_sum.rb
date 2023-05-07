# frozen_string_literal: true

class MatrixElementSum
  def self.sum(matrix)
    ignore_columns = []
    sum = 0
    matrix.each do |row|
      (0...row.size).each do |j|
        next if ignore_columns.include? j

        ignore_columns << j if (row[j]).zero?
        sum += row[j]
      end
    end
    sum
  end
end
