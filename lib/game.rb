require_relative 'board'
require_relative 'player'

class Game
  def initialize
    puts 'type your name player 1!'
    @player1 = Player.new
    puts 'type your name player 2!'
    @player2 = Player.new
    @board = Board.new
  end

  def win?(player)
    @board.check_four_in_column(player.piece) || @board.check_four_in_diagonal(player.piece) || @board.check_four_in_row(player.piece)
  end

  def round
    return if @board.full?

    @player1.turn(@board)
    return if win?(@player1)

    @player2.turn(@board)
  end

  def start
    check_pieces
    until @board.full?
      round

      break if win?(@player1) || win?(@player2)

    end
    if win?(@player1)
      @player1.win
    elsif win > (@player2)
      @player2.win
    else
      puts 'This is a draw!'
    end
    @board.print_board
  end

  def check_pieces
    return unless @player1.piece == @player2.piece

    puts "#{@player1.name} your piece has been changed because it was the same to the piece of your rival!"
    @player1.piece = if @player1.piece == "\u26AA"
                       "\u26AB"
                     else
                       "\u26AA"
                     end
  end
end
