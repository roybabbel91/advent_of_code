FLOOR_MAP = File.readlines("../data.txt", chomp: :true).map { |l| l.chars.map(&:to_i) }
MAX_FLOOR_HEIGHT = 9

def low_points
  FLOOR_MAP.flat_map.with_index { |row, i|
    row.map.with_index { |val, j| [i, j] if low_point?(i, j) }
  }.compact
end

def low_point?(row, col)
  cur   = FLOOR_MAP[row][col]

  surrounding_coordinates(row, col).map do |i, j|
    FLOOR_MAP[i][j]
  end.all? { |v| cur < v }
end

def surrounding_coordinates(row, col)
  coordinates = []
  coordinates << [row - 1, col] if row > 0
  coordinates << [row, col - 1] if col > 0
  coordinates << [row + 1, col] if row < FLOOR_MAP.length - 1
  coordinates << [row, col + 1] if col < FLOOR_MAP.first.length - 1

  coordinates
end

def basin_size(row, col)
  to_visit = [[row, col]]
  basin = {}

  while to_visit.length > 0 do
    r, c = to_visit.shift
    basin["#{r},#{c}"] = true

    to_visit += surrounding_coordinates(r, c).select do |i, j|
      basin["#{i},#{j}"].nil? && FLOOR_MAP[i][j] < 9
    end
  end

  basin.keys.size
end

def max_danger
  low_points.map { |coords| basin_size(*coords) }.sort.reverse[0..2].inject(:*)
end

puts max_danger