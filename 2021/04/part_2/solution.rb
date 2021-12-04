require "../bingo_game.rb"

bingo_game = ::BingoGame.new

File.foreach("../called_numbers_data.txt", ',', chomp: true) do |num|
  break if bingo_game.announce_number(num).remaining_players_count.zero?
end

puts bingo_game.bingos.first.remaining_numbers.map(&:to_i).sum * bingo_game.announced_numbers.last.to_i