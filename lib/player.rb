require_relative 'board'

class Player
  attr_reader :name
  attr_accessor :piece

  def initialize
    @name = user_name
    @piece = user_piece
  end

  def select_column(board)
    puts "#{@name}, select a column!"
    board.print_board
    column = gets.chomp until column =~ /^[1-7]$/
    if board.full_column?(column.to_i - 1)
      puts 'That column is full! select another one'
      new_column = gets.chomp
      new_column = gets.chomp until new_column =~ /^[1-7]$/ && new_column != column
      return new_column.to_i - 1
    end
    column.to_i - 1
  end

  def win
    puts "Congratulations! #{@name} you win!"
  end

  def user_piece
    puts "select a piece!\n type 0 for \u26AA or type 1 for \u26AB"
    piece = gets.chomp until piece =~ /[0-1]/
    @piece = if piece == '0'
               "\u26AA"
             else
               "\u26AB"
             end
  end

  def user_name
    gets.chomp
  end

  def turn(board)
    column_index = select_column(board)
    board.insert(column_index, @piece)
  end
end
