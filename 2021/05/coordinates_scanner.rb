module CoordinatesScanner
  COORDINATES_REGEXP = /^(\d+),(\d+)\s->\s(\d+),(\d+)/

  def coordinates_to_count(include_diagnals = false)
    @coordinates_to_count ||= begin
      File.foreach("../data.txt").with_object({}) do |line, h|
        x1, y1, x2, y2 = COORDINATES_REGEXP.match(line)[1..-1].map(&:to_i)
        
        if y1 == y2
          x1, x2 = [x1, x2].sort
          (x1..x2).each do |x|
            coords = [x,y1].join(",")
            h[coords] ||= 0
            h[coords] += 1
          end
        elsif x1 == x2
          y1, y2 = [y1, y2].sort
          (y1..y2).each do |y|
            coords = [x1,y].join(",")
            h[coords] ||= 0
            h[coords] += 1
          end
        elsif(include_diagnals)
          done = false
          i = x1 < x2 ? 1 : -1
          j = y1 < y2 ? 1 : -1

          loop do
            coords = [x1,y1].join(",")
            h[coords] ||= 0
            h[coords] += 1
            x1 += i
            y1 += j
            break if done
            done = x1 == x2
          end
        end
      end
    end
  end
end
