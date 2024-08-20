require_relative '../lib/board'

describe Board do
  ## Evaluate the instance variables and the methods at first when the table is created
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
end
