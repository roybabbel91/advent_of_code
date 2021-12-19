class CaveSystem

  attr_accessor :caves, :visited_small_caves, :paths_count

  def initialize
    @caves = Hash.new([])
    @visited_small_caves = Hash.new(false)
    @paths_count = 0
  end

  def add_vertex(a, b)
    @caves[a] += [b]
    @caves[b] += [a]
  end

  def traverse_from_start
    @visited_small_caves["start"] = true
    traverse(caves["start"])
  end

  def traverse(to_visit = [], path = ["start"])
    to_visit.each do |cave|
      next if visited_small_caves[cave]

      if cave == "end"
        puts (path + ["end"]).join("->")
        @paths_count += 1
      else
        toggle_visited(cave)
        path += [cave]
        traverse(caves[cave], path)
        path.pop
        toggle_visited(cave)
      end
    end
  end

  def toggle_visited(cave)
    return unless small?(cave)

    @visited_small_caves[cave] = !visited_small_caves[cave]
  end

  def small?(cave)
    cave == cave.downcase
  end
end

cave_system = CaveSystem.new

File.foreach("../data.txt", chomp: true) do |line|
  cave_system.add_vertex(*line.split("-"))
end

cave_system.traverse_from_start
puts cave_system.paths_count
