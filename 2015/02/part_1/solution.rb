sf_count = 0

File.foreach("../data.txt") do |line|
  l, w, h = line.split("x").map(&:to_i).sort
  sf_count += 3*l*w + 2*w*h + 2*h*l
end

puts sf_count