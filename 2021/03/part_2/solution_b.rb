class Node
  attr_accessor :value, :left, :right
  def initialize(value = 0, left = nil, right = nil)
    self.value = value
    self.left = left
    self.right = right
  end

  def traverse(direction = :greater)
    path = ""
    current = self
    while current.left || current.right do
      if current.go_left?(direction)
        path += "0"
        current = current.left
      else
        path += "1"
        current = current.right
      end
    end

    path
  end

  def go_left?(direction)
    return true if right.nil?
    return false if left.nil?

    case direction
    when :greater
      left.value.to_i > right.value.to_i
    when :less
      left.value.to_i <= right.value.to_i
    else
      raise "Invalid direction #{direction}"
    end
  end
end

root = Node.new
File.foreach("../data.txt") do |line|
  current = root
  line.chomp.chars.each do |c|
    case c
    when "0"
      current.left ||= Node.new(0)
      current = current.left
      current.value += 1
    else
      current.right ||= Node.new(0)
      current = current.right
      current.value += 1
    end
  end
end

puts root.traverse.to_i(2) * root.traverse(:less).to_i(2)