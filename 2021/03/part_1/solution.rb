counts = []
total = 0

File.foreach("../data.txt") do |line|
  counts = (0..(line.length - 1)).map do |i|
    counts[i].to_i + line[i].to_i
  end
  total += 1
end

midpoint = total / 2
counts.map! { |count| count > midpoint ? 1 : 0 }
inverse = counts.map { |v| (v + 1) % 2 }

puts counts.join.to_i(2) * inverse.join.to_i(2)
