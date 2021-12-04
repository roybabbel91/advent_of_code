class BingoBoard
  def initialize(numbers = [[]])
    self.numbers = numbers
    self.called_numbers = {}
  end

  def mark(number)
    called_numbers[number] = true
    self
  end

  def bingo?
    connected_diagnals? || connected_rows? || connected_columns?
  end

  def remaining_numbers
    numbers.flat_map do |row|
      row.select { |n| !called_numbers[n] }
    end
  end

  private

  attr_accessor :numbers, :called_numbers

  def size
    @size ||= numbers.first.length
  end

  def connected_diagnals?
    connected?(0, 0, 1, 1) || connected?(0, (size - 1), 1, -1)
  end

  def connected_rows?
    (0..(size - 1)).any? do |i|
      connected?(i, 0, 0, 1)
    end
  end

  def connected_columns?
    (0..(size - 1)).any? do |j|
      connected?(0, j, 1, 0)
    end
  end

  def connected?(i, j, i_increment, j_increment)
    k = 0
    while i < size && j < size do
      number = numbers[i][j]
      break unless called_numbers[number]

      i += i_increment
      j += j_increment
      k += 1
    end

    k == size
  end
end
