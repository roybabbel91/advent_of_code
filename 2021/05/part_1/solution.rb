require "../coordinates_scanner"
include CoordinatesScanner

puts coordinates_to_count.count { |k, v| v > 1 }