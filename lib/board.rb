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

  def check_four_in_row(piece)
    win = false
    @table.each do |row|
      win = true if row.each_cons(4).any? { |four_in_row| four_in_row.all? { |cell| cell == piece } }
    end
    win
  end

  def check_four_in_column(piece)
    transpose_table = @table.transpose
    win = false
    transpose_table.each do |column|
      win = true if column.each_cons(4).any? { |four_in_column| four_in_column.all? { |cell| cell == piece } }
    end
    win
  end

  def check_four_in_diagonal(piece)
    diagonals = find_diagonals
    anti_diagonals = find_anti_diagonals
    win = false
    diagonals.each { |diagonal| win = true if diagonal.all? { |cell| cell == piece } }
    anti_diagonals.each { |diagonal| win = true if diagonal.all? { |cell| cell == piece } }
    win
  end

  def find_diagonals
    diagonals = []

    (0...6).each do |r|
      (0...7).each do |c|
        next unless r + 4 <= 6 && c + 4 <= 7

        diagonal = []
        4.times do |i|
          diagonal << @table[r + i][c + i]
        end
        diagonals << diagonal if diagonal.size == 4
      end
    end
    diagonals
  end

  def find_anti_diagonals
    diagonals = []
    (0...6).each do |r|
      (0...7).each do |c|
        next unless r + 4 <= 6 && c - 4 + 1 >= 0

        diagonal = []
        4.times do |i|
          diagonal << @table[r + i][c - i]
        end
        diagonals << diagonal if diagonal.size == 4
      end
    end

    diagonals
  end
end
