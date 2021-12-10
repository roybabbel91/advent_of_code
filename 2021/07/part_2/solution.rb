nums = File.readlines("../data.txt", ",", chomp: true).map(&:to_i)
average = nums.sum / nums.length

puts nums.sum { |n| (1..(n - average).abs).sum }