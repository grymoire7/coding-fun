# Calculate if sequence is almost increasing.
# That is, strictly increasing if you remove no more than one element from
# the array.
#
class AlmostIncreasing
  def self.check(sequence)
    return false if sequence.size <= 1

    bad_indices = non_increasing_indices(sequence)
    puts "seq = #{sequence}"
    puts "bad = #{bad_indices}"
    return false if bad_indices.size > 1
    return true  if bad_indices.empty?

    bad_indices.each do |i|
      seq = sequence.clone
      puts "Removing #{seq[i]} at #{i}"
      seq.delete_at i
      return true if non_increasing_indices(seq).empty?

      if i < sequence.size - 1
        seq = sequence.clone
        seq.delete_at i + 1
        return true if non_increasing_indices(seq).empty?
      end
    end
    false
  end

  def self.non_increasing_indices(sequence)
    non_increasing_indices = []
    (0..(sequence.size - 2)).each do |i|
      a, b = sequence[i..(i + 1)]
      if !(a < b)
        non_increasing_indices << i
      end
    end
    non_increasing_indices
  end

  # Brute force works but takes too long.
  def self.brute_force(sequence)
    (0...sequence.size).each do |i|
      seq = sequence.clone
      seq.delete_at i
      seq_fail = false
      seq.each_cons(2) do |a, b|
        seq_fail = true if a >= b
      end
      return true unless seq_fail
    end
    false
  end
end
