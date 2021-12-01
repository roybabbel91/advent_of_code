previous = 1_000_000_000_000
count = 0

File.foreach("../data.txt") do |line|
  count += 1 if previous < line.to_i
  previous = line.to_i
end

puts count
