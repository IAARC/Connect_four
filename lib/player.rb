require_relative 'board'

class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece
  end

  def select_column(board)
    puts 'Select a column!'
    board.print_board
    column = gets.chomp until column =~ /[0-6]/
    column.to_i - 1
  end

  def win
    "Congratulations! #{@name} you win!"
  end

  def select_piece
    puts "select a piece!\n type 0 for \u26AA or type 1 for \u26AB"
    piece = gets.chomp until piece =~ /[0-1]/
    @piece = if piece == '0'
               "\u26AA"
             else
               "\u26AB"
             end
  end

  def turn(board)
    column_index = select_column(board)
    board.insert(column_index, @piece)
  end
end
