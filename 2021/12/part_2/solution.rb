class CaveSystem

  attr_accessor :caves, :small_cave_visit_counts, :paths_count, :more_than_once_count

  SMALL_CAVE_ALLOWANCE = 1

  def initialize
    @caves = Hash.new([])
    @small_cave_visit_counts = Hash.new(0)
    @paths_count = 0
    @more_than_once_count = 0
  end

  def add_vertex(a, b)
    @caves[a] += [b]
    @caves[b] += [a]
  end

  def traverse_from_start
    traverse(caves["start"])
  end

  def traverse(to_visit = [], path = ["start"])
    to_visit.each do |cave|
      next if allowance_met?(cave)

      if cave == "end"
        print "- " if more_than_once_count > 0
        puts (path + ["end"]).join("->")
        @paths_count += 1
      else
        add_visited(cave)
        path += [cave]
        traverse(caves[cave], path)
        path.pop
        remove_visited(cave)
      end
    end
  end

  def add_visited(cave)
    return unless small?(cave)

    @small_cave_visit_counts[cave] = small_cave_visit_counts[cave] + 1
    @more_than_once_count = more_than_once_count + small_cave_visit_counts[cave] - 1
  end

  def remove_visited(cave)
    return unless small?(cave)

    @small_cave_visit_counts[cave] = small_cave_visit_counts[cave] - 1
    @more_than_once_count = more_than_once_count - 1 if small_cave_visit_counts[cave] > 0
  end

  def small?(cave)
    cave == cave.downcase
  end

  def allowance_met?(cave)
    cave == "start" || small_cave_visit_counts[cave] > 0 && more_than_once_count == SMALL_CAVE_ALLOWANCE
  end
end

cave_system = CaveSystem.new

File.foreach("../data.txt", chomp: true) do |line|
  cave_system.add_vertex(*line.split("-"))
end

cave_system.traverse_from_start
puts cave_system.paths_count
