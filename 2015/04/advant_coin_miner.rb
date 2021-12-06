require 'digest'

class AdventCoinMiner
  SECRET = "ckczppom"

  def initialize(count = 0, regexp_condition = /^0{5}.*/)
    self.count = count
    self.coins = []
    self.regexp_condition = regexp_condition
  end

  def mine_next_coin
    until regexp_condition.match?(digest) do
      self.count += 1
    end
    self.coins << count
    self.count += 1

    coins.last
  end

  private

  attr_accessor :count, :coins, :regexp_condition

  def digest
    Digest::MD5.hexdigest("#{SECRET}#{count}")
  end
end
