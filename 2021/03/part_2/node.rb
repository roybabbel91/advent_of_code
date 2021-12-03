class Node
  attr_accessor :value, :left, :right
  def initialize(value = 0, left = nil, right = nil)
    self.value = value
    self.left = left
    self.right = right
  end

  def most
    path = ""
    current = self
    while current.left || current.right do
      if current.left&.value.to_i > current.right&.value.to_i
        path += "0"
        current = current.left
      else
        path += "1"
        current = current.right
      end
    end

    path
  end

  def least
    path = ""
    current = self
    while current.left || current.right do
      if current.left
        if current.right
          if current.left.value.to_i > current.right.value.to_i
            path += "1"
            current = current.right
          else
            path += "0"
            current = current.left
          end
        else
          path += "0"
          current = current.left
        end
      else
        path += "1"
        current = current.right
      end
    end

    path
  end
end