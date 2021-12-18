FLOOR_MAP = File.readlines("../data.txt", chomp: :true).map { |l| l.chars.map(&:to_i) }
MAX_FLOOR_HEIGHT = 9

def max_danger
  low_points.sum(0) { |v| v + 1 }
end

def low_points
  FLOOR_MAP.flat_map.with_index { |row, i|
    row.select.with_index { |val, j| low_point?(i, j) }
  }
end

def low_point?(row, col)
  cur   = FLOOR_MAP[row][col]
  top   = FLOOR_MAP[row - 1] && FLOOR_MAP[row - 1][col] || MAX_FLOOR_HEIGHT
  left  = FLOOR_MAP[row][col - 1] || MAX_FLOOR_HEIGHT
  right = FLOOR_MAP[row][col + 1] || MAX_FLOOR_HEIGHT
  bot   = FLOOR_MAP[row + 1] && FLOOR_MAP[row + 1][col] || MAX_FLOOR_HEIGHT

  sorted = [cur, top, left, right, bot].sort
  cur < sorted[1]
end

puts max_danger