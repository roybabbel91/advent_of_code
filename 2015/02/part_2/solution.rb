count = 0

File.foreach("../data.txt") do |line|
  l, w, h = line.split("x").map(&:to_i).sort
  count += 2*l + 2*w + l*w*h
end

puts count