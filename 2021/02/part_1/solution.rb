x, y = [0, 0]

File.foreach("../data.txt") do |line|
  direction, unit = line.split(" ")

  case direction
  when "up"
    y -= unit.to_i
  when "down"
    y += unit.to_i
  when "forward"
    x += unit.to_i
  else
    puts "invalid instructions #{line}}"
  end
end

puts x * y