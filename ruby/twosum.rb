require 'rspec/autorun'

def two_sumx(nums, target)
  nums.each_with_index do |num, idx|
    # next if num > target
    prey = target - num
    # puts "target = #{target}, num = #{num}, prey = #{prey}"
    ((idx + 1)...nums.size).each do |prey_idx|
      # puts "look = #{nums[prey_idx]}, idx = #{idx}, prey_idx = #{prey_idx}, prey = #{prey}"
      return [idx, prey_idx] if nums[prey_idx] == prey
    end
  end
  [0, 0]
end

def two_sum(nums, target)
  nums.each_with_index do |num, idx|
    prey = target - num
    search_idx = nums.rindex(prey)
    return [idx, search_idx] if search_idx && search_idx != idx
  end
  [0, 0]
end

RSpec.describe '#two_sum' do
  describe '#two_sum' do
    it 'works' do
      expect(two_sum([2, 7, 15, 11], 17)).to eq([0, 2])
      expect(two_sum([3, 3], 6)).to eq([0, 1])
      expect(two_sum([-1, -2, -3, -4, -5], -8)).to eq([2, 4])
      expect(two_sum([3, 2, 4], 6)).to eq([1, 2])
    end
  end
end
