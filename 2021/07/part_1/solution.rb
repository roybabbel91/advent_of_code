nums = File.readlines("../data.txt", ",", chomp: true).map(&:to_i).sort
mode = nums[nums.length / 2]

puts nums.sum { |n| (n - mode).abs }