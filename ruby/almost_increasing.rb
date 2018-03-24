# Calculate if sequence is almost increasing.
# That is, strictly increasing if you remove no more than one element from
# the array.
#
class AlmostIncreasing

  def self.check(sequence)
    return false if sequence.size <= 1
    bad_indices = self.nonIncreasingIndices(sequence)
    puts "seq = #{sequence}"
    puts "bad = #{bad_indices}"
    return false if bad_indices.size > 1
    return true  if bad_indices.empty?
    bad_indices.each do |i|
      seq = sequence.clone
      puts "Removing #{seq[i]} at #{i}"
      seq.delete_at i
      return true if nonIncreasingIndices(seq).empty?
      if (i < sequence.size - 1)
        seq = sequence.clone
        seq.delete_at i+1
        return true if nonIncreasingIndices(seq).empty?
      end
    end
    false
  end

  def self.nonIncreasingIndices(sequence)
    non_increasing_indices = []
    (0..(sequence.size-2)).each do |i|
      a, b = sequence[i..(i+1)]
      if !( a < b )
        non_increasing_indices << i
      end
    end
    non_increasing_indices
  end

  # Brute force works but takes too long.
  def self.bruteForce(sequence)
    (0...sequence.size).each do |i|
      seq = sequence.clone
      seq.delete_at i
      seqFail = false
      seq.each_cons(2) do |a, b|
        seqFail = true if a >= b
      end
      return true if not seqFail
    end
    false
  end
end
