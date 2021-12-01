count = 0
position = 0

File.readlines("../data.txt").first.chars.each do |c|
  position += 1

  case c
  when "("
    count += 1
  when ")"
    count -= 1
  else
    puts "Not a paren #{c}"
  end

  break if count < 0
end

puts position