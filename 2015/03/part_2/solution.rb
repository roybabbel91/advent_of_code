visited = { "0,0" => true }
coordinates = [[0,0],[0,0]]
idx = 0

File.readlines("../data.txt").first.chars.each do |dir|
  case dir
  when '^'
    coordinates[idx][0] += 1
  when "v"
    coordinates[idx][0] -= 1
  when '>'
    coordinates[idx][1] += 1
  when '<'
    coordinates[idx][1] -= 1
  else
    puts "invalid direction #{dir}"
  end

  visited[coordinates[idx].join(",")] = true
  idx = (idx + 1) % 2
end

puts visited.keys.size