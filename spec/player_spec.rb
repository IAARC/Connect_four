require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('andres', 0) }

  describe '#initialize' do
    it 'return the name' do
      expect(player.name).to eql('andres')
    end

    it 'return the piece' do
      expect(player.piece).to eql(0)
    end
  end

  describe '#win' do
    it 'return win message' do
      expect(player.win).to eql('Congratulations! andres you win!')
    end
  end

  describe '#select_piece' do
    before do
      allow_any_instance_of(Object).to receive(:puts)
    end

    it 'return the white circle when 0 is selected' do
      allow(player).to receive(:gets).and_return("0\n")
      player.select_piece
      expect(player.piece).to eql("\u26AA")
    end

    it 'return the black circle when 1 is selected' do
      allow(player).to receive(:gets).and_return("1\n")
      player.select_piece
      expect(player.piece).to eql("\u26AB")
    end
  end
end
