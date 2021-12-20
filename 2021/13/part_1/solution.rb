coordinates = {}
folds = []

File.foreach("../coordinates_data.txt", chomp: true) do |line|
  coordinates[line] = true
end

File.foreach("../folds_data.txt", chomp: true) do |line|
  axis, value = line.split(" ").last.split("=")
  folds << [axis, value.to_i]
end

axis, fold_value = folds.first
idx = axis == "x" ? 0 : 1
max = coordinates.keys.map { |c| c.split(",")[idx].to_i }.max
offset = [max - 2 * fold_value, 0].max

coordinates = coordinates.keys.each_with_object({}) do |coords, transposed|
  coords = coords.split(",").map(&:to_i)

  if coords[idx] <= fold_value
    coords[idx] = coords[idx] + offset
  elsif coords[idx] <= 2 * fold_value
    coords[idx] = (2 * fold_value - coords[idx]) + offset
  else
    coords[idx] = y_offset - (coords[idx] - 2 * fold_value)
  end

  transposed[coords.join(",")] = true
end

puts coordinates.keys.size
