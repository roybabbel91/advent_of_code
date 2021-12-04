require '../bingo_board'

class BingoGame
  attr_reader :announced_numbers, :bingos

  def initialize
    self.announced_numbers = []
    self.bingos = []
  end

  def announce_number(number)
    announced_numbers << number
    self.bingos = players.select { |p| p.mark(number).bingo? }
    @players -= bingos
    self
  end

  def bingos?
    bingos.any?
  end

  def remaining_players_count
    players.count
  end

  private

  attr_writer :announced_numbers, :bingos

  def players
    @players ||= from_file
  end

  def from_file
    board = []
    boards = []

    File.foreach('../bingo_boards_data.txt', chomp: true) do |line|
      if line.length > 0
        board << line.split(' ')
      else
        boards << ::BingoBoard.new(board)
        board = []
      end
    end

    boards
  end
end
