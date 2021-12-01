visited = { "0,0" => true }
coordinates = [0,0]

File.readlines("../data.txt").first.chars.each do |dir|
  case dir
  when '^'
    coordinates[0] += 1
  when "v"
    coordinates[0] -= 1
  when '>'
    coordinates[1] += 1
  when '<'
    coordinates[1] -= 1
  else
    puts "invalid direction #{dir}"
  end

  visited[coordinates.join(",")] = true
end

puts visited.keys.size