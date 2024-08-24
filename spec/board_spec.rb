require_relative '../lib/board'
require_relative '../lib/player'

describe Board do
  context 'initiated the board, board empty and no move' do
    subject(:board) { described_class.new }
    describe '#initialize' do
      matcher :be_seven_size do
        match { |array| array.length == 7 }
      end
      it 'is a 6 row board' do
        expect(board.table.length).to eql(6)
      end

      it 'is a 7 column board' do
        expect(board.table).to all(be_seven_size)
      end
    end

    describe '#insert' do
      it 'insert in the board a piece by a given column' do
        board.insert(2, 'yellow')
        expect(board.table[5][2]).to eql('yellow')
      end
    end

    describe '#last_row_empty' do
      it 'return the last index(5)' do
        column_index = 1
        row_index = board.last_row_empty(column_index)
        expect(row_index).to eql(5)
      end
    end
  end

  context 'when half board full' do
    subject(:board) { described_class.new }

    describe '#last_row_empty' do
      it 'return 2' do
        board.table = [[nil, nil, nil, nil, nil, nil, nil],
                       [nil, nil, nil, nil, nil, nil, nil],
                       [nil, nil, nil, nil, nil, nil, nil],
                       [0, 1, 0, 1, 1, 0, 0],
                       [0, 1, 0, 1, 0, 1, 0],
                       [1, 1, 0, 1, 0, 0, 1]]
        column_index = 0
        row_index = board.last_row_empty(column_index)
        expect(row_index).to eql(2)
      end
    end

    describe '#insert' do
      it 'insert in the position (2,0) the number 1' do
        board.table = [[nil, nil, nil, nil, nil, nil, nil],
                       [nil, nil, nil, nil, nil, nil, nil],
                       [nil, nil, nil, nil, nil, nil, nil],
                       [0, 1, 0, 1, 1, 0, 0],
                       [0, 1, 0, 1, 0, 1, 0],
                       [1, 1, 0, 1, 0, 0, 1]]
        column_index = 0
        board.insert(column_index, 1)
        expect(board.table[2][0]).to eql(1)
      end
    end
  end

  context 'full board' do
    subject(:board) { described_class.new }
    describe 'last_row_empty' do
      it 'returns nil' do
        board.table = [[0, 1, 0, 0, 1, 1, 1],
                       [1, 1, 0, 1, 0, 0, 0],
                       [1, 0, 0, 1, 1, 0, 1],
                       [0, 1, 0, 1, 1, 0, 0],
                       [0, 1, 0, 1, 0, 1, 0],
                       [1, 1, 0, 1, 0, 0, 1]]
        row_index = board.last_row_empty(0)
        expect(row_index).to eql(nil)
      end
    end

    describe 'insert' do
      it 'returns nil' do
        board.table = [[0, 1, 0, 0, 1, 1, 1],
                       [1, 1, 0, 1, 0, 0, 0],
                       [1, 0, 0, 1, 1, 0, 1],
                       [0, 1, 0, 1, 1, 0, 0],
                       [0, 1, 0, 1, 0, 1, 0],
                       [1, 1, 0, 1, 0, 0, 1]]
        expect(board.insert(2, 'yellow')).to eql(nil)
      end
    end

    describe 'full?' do
      it 'returns true' do
        board.table = [[0, 1, 0, 0, 1, 1, 1],
                       [1, 1, 0, 1, 0, 0, 0],
                       [1, 0, 0, 1, 1, 0, 1],
                       [0, 1, 0, 1, 1, 0, 0],
                       [0, 1, 0, 1, 0, 1, 0],
                       [1, 1, 0, 1, 0, 0, 1]]
        expect(board.full?).to eql(true)
      end
    end
  end

  describe '#check_four_in_row' do
    let(:player) { Player.new('andres', "\u26AA") }
    let(:board) { described_class.new }
    before do
      board.insert(0, player.piece)
      board.insert(1, player.piece)
      board.insert(2, player.piece)
      board.insert(3, player.piece)
    end
    it 'return true if there is 4 in row' do
      expect(board.check_four_in_row(player.piece)).to be true
    end

    it 'return false if there is not 4 in row' do
      board.table[5][3] = nil
      board.table[5][4] = player.piece
      expect(board.check_four_in_row(player.piece)).to be false
    end
  end

  describe '#check_four_in_column' do
    let(:player) { Player.new('andres', "\u26AA") }
    let(:board) { described_class.new }
    before do
      board.insert(2, player.piece)
      board.insert(2, player.piece)
      board.insert(2, player.piece)
      board.insert(2, player.piece)
    end

    it 'return true if there is 4 in column' do
      expect(board.check_four_in_column(player.piece)).to be true
    end

    it 'return false if there isnt 4 in column' do
      board.table[4][2] = nil
      expect(board.check_four_in_column(player.piece)).to be false
    end
  end

  describe '#check_four_in_diagonal' do
    let(:player) { Player.new('andres', "\u26AA") }
    let(:board) { described_class.new }
    before do
      board.table[0][0] = "\u26AA"
      board.table[1][1] = "\u26AA"
      board.table[2][2] = "\u26AA"
      board.table[3][3] = "\u26AA"
      board.table[5][0] = "\u26AA"
      board.table[4][1] = "\u26AA"
      board.table[3][2] = "\u26AA"
      board.table[2][3] = "\u26AA"
    end

    it 'return true if there is 4 in diagonal' do
      expect(board.check_four_in_diagonal(player.piece)).to be true
    end

    it 'return true if there is 4 in anti-diagonal' do
      expect(board.check_four_in_diagonal(player.piece)).to be true
    end

    it 'return false if there isnt 4 in any diagonal' do
      board.table[3][3] = nil
      board.table[2][3] = nil
      expect(board.check_four_in_diagonal(player.piece)).to be false
    end
  end
end
