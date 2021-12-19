class DumboOctopus
  MAX_CHARGE = 10

  attr_accessor :neighbors, :flashes, :energy

  def initialize(energy)
    @energy = energy
    @flashes = {}
    @neighbors = []
  end

  def increment(cycle)
    return if flashes[cycle]

    @energy = (energy + 1) % MAX_CHARGE
    return unless energy.zero?

    flashes[cycle] = true
    neighbors.each { |n| n.increment(cycle) }
  end
end

octopi = File.readlines("../data.txt", chomp: true).flat_map.with_index do |line, i|
  line.chars.map.with_index do |v, j|
    [[i,j], DumboOctopus.new(v.to_i)]
  end
end.to_h

def neighbors(octopi, i, j)
  [
    octopi[[i - 1, j - 1]],
    octopi[[i - 1, j]],
    octopi[[i - 1, j + 1]],
    octopi[[i + 1, j + 1]],
    octopi[[i + 1, j]],
    octopi[[i + 1, j - 1]],
    octopi[[i, j + 1]],
    octopi[[i, j - 1]],
  ].compact
end

octopi.each do |k, o| o.neighbors = neighbors(octopi, *k) end

cycle = 0

loop do
  cycle += 1
  octopi.each { |k, o| o.increment(cycle) }
  break if octopi.all? { |k, o| o.flashes[cycle] }
end

puts cycle
