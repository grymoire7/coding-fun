require 'rspec/autorun'

# Calculate if sequence is almost increasing.
# That is, strictly increasing if you remove no more than one element from
# the array.
#
class AlmostIncreasing
  def check(sequence)
    # brute_force(sequence)
    # works_but_ugly(sequence)
    better(sequence)
  end

  private

  def better(sequence)
    return false if sequence.size <= 1

    diffs = sequence.zip(sequence.rotate).map { |a, b| b - a }[0..-2]

    diffs.one? { |a| a <= 0 }
  end

  # works, but it's pretty ugly
  def works_but_ugly(sequence)
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

      next if i >= sequence.size - 1

      seq = sequence.clone
      seq.delete_at i + 1
      return true if non_increasing_indices(seq).empty?
    end
    false
  end

  def non_increasing_indices(sequence)
    non_increasing_indices = []
    (0..(sequence.size - 2)).each do |i|
      # a, b = sequence[i..(i + 1)]
      a, b = sequence.slice(i, 2)
      if !(a < b)
        non_increasing_indices << i
      end
    end
    non_increasing_indices
  end

  # Brute force works but takes too long.
  def brute_force(sequence)
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

RSpec.describe 'AmostIncreasing' do
  describe '#check' do
    subject { AlmostIncreasing.new }

    it 'solves example 1' do
      expect(subject.check([1, 3, 2, 1])).to eq(false)
    end

    it 'solves example 2' do
      expect(subject.check([1, 3, 2])).to eq(true)
    end

    it 'solves example 3' do
      expect(subject.check([1, 2, 5, 3, 5])).to eq(true)
    end

    it 'solves example 4' do
      expect(subject.check([])).to eq(false)
    end

    it 'solves example 5' do
      expect(subject.check([1])).to eq(false)
    end
  end
end
