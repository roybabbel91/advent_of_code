count = 0

File.readlines("../data.txt").first.chars.each do |c|
  case c
  when "("
    count += 1
  when ")"
    count -= 1
  else
    puts "Not a paren #{c}"
  end
end

puts count