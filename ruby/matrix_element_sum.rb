#
class MatrixElementSum

  def self.sum(matrix)
    ignoreColumns = []
    sum = 0
    matrix.each do |row|
      (0...row.size).each do |j|
        next if ignoreColumns.include? j
        ignoreColumns << j if row[j] == 0
        sum += row[j]
      end
    end
    sum
  end

end
