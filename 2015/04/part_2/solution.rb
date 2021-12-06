require "../advant_coin_miner.rb"

miner = AdventCoinMiner.new(117946, /^0{6}.*/)

puts miner.mine_next_coin