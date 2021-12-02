x, y, z = [0, 0, 0]

File.foreach("../data.txt") do |line|
  direction, unit = line.split(" ")

  case direction
  when "up"
    z -= unit.to_i
  when "down"
    z += unit.to_i
  when "forward"
    x += unit.to_i
    y += unit.to_i * z
  else
    puts "invalid instructions #{line}}"
  end
end

puts x * y