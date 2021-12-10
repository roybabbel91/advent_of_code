nums = File.readlines("../data.txt", ",", chomp: true).map(&:to_i).sort
median = nums.median

puts nums.sum { |n| (n - median).abs }