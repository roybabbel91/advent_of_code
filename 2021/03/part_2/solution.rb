most = []
least = []
hash = { "0" => [], "1" => []}
idx = 0

File.foreach("../data.txt") do |line|
  hash[line[idx]] << line.chomp
end

if hash["0"].length > hash["1"].length
  most = hash["0"].map { |v| v }
  least = hash["1"].map { |v| v }
else
  most = hash["1"].map { |v| v }
  least = hash["0"].map { |v| v }
end

idx = 1
while most.length > 1 do
  hash = { "0" => [], "1" => [] }
  most.each do |v| hash[v[idx]] << v end
  
  if hash["0"].length > hash["1"].length
    most = hash["0"].map { |v| v }
  else
    most = hash["1"].map { |v| v }
  end
  idx += 1
end

idx = 1
while least.length > 1 do
  hash = { "0" => [], "1" => [] }
  least.each do |v| hash[v[idx]] << v end
  
  if hash["0"].length > hash["1"].length
    least = hash["1"].map { |v| v }
  else
    least = hash["0"].map { |v| v }
  end
  idx += 1
end

puts most.first.to_i(2) * least.first.to_i(2)
