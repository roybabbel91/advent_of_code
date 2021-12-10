count = 0

sizes = [2,3,4,7]

File.foreach("../data.txt") do |line|
  line.split("|").last.scan(/[a-g]+/).each do |m|
    count += 1 if sizes.include?(m.size)
  end
end

puts count