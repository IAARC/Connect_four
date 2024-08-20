class Board
  attr_accessor :table

  def initialize
    @table = [[nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil]]
  end

  def last_row_empty(column_index)
    return if full?

    i = 5
    i -= 1 until @table[i][column_index].nil?
    i
  end

  def insert(column_index, player_piece)
    return if full?

    row_index = last_row_empty(column_index)
    @table[row_index][column_index] = player_piece
  end

  def full?
    @table[0].all? { |item| !item.nil? }
  end

  def print_board
    (1..@table[0].size).each { |i| print "  #{i}  " }
    puts

    puts '-' * (@table[0].size * 5)

    @table.each do |row|
      row.each do |cell|
        print "[ #{cell.nil? ? ' ' : cell} ]"
      end
      puts
    end
  end
end

board = Board.new
board.print_board
