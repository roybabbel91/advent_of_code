window = []
window_size = 3
count = 0

File.foreach("../data.txt") do |line|
  window << line.to_i
  next if window.size < window_size + 1

  current = window[1..window_size].sum
  previous = window[0..(window_size - 1)].sum
  count += 1 if previous < current
  window.delete_at(0)
end

puts count
