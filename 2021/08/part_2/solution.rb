WORD_TO_INT = {
  "abcefg"  => 0,
  "cf"      => 1,
  "acdeg"   => 2,
  "acdfg"   => 3,
  "bcdf"    => 4,
  "abdfg"   => 5,
  "abdefg"  => 6,
  "acf"     => 7,
  "abcdefg" => 8,
  "abcdfg"  => 9,
}

def total
  sum = 0

  File.foreach("../data.txt") do |line|
    sum += calculated_value(*line.split(" | "))
  end

  sum
end

def calculated_value(cypher, code)
  positions = decypher_positions(cypher)

  code.split(" ").map { |word|
    decyphered_word = word.chars.map { |c| positions[c] }.sort.join
    WORD_TO_INT[decyphered_word]
  }.join.to_i
end

def decypher_positions(cypher)
  nums = Array.new(10)
  positions = {}
  words_hash = cypher.split(" ").each_with_object(Hash.new([])) do |word, obj|
    obj[word.length] += [word.chars]
  end
  nums[1] = words_hash[2].first
  nums[7] = words_hash[3].first
  nums[4] = words_hash[4].first
  nums[8] = words_hash[7].first
  nums[2] = words_hash[5].select { |w| (w - (nums[4] + nums[7])).length == 2 }.first
  words_hash[5] -= [nums[2]]
  positions["a"] = (nums[7] - nums[4]).first
  positions["g"] = (words_hash[5].first - (nums[7] + nums[4])).first
  positions["e"] = (nums[2] - (nums[4] + words_hash[5].first)).first
  positions["b"] = (nums[4] - (nums[7] + nums[2])).first
  positions["f"] = (nums[1] - nums[2]).first
  positions["c"] = (nums[1] - [positions["f"]]).first
  positions["d"] = (nums[8] - positions.values).first
  
  positions.map { |k, v| [v, k] }.to_h
end

puts total

