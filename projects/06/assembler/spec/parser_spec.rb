require_relative '../parser'

describe Parser do
  describe '#command_type' do
    it "returns A_COMMAND when there's an @ symbol" do
      p = Parser.new(StringIO.new("@100\n"))
      p.advance
      expect(p.command_type).to eq('A_COMMAND')
    end

    it "returns L_COMMAND when there's a symbolic reference" do
      p = Parser.new(StringIO.new("(LOOP)\n"))
      p.advance
      expect(p.command_type).to eq('L_COMMAND')
    end

    it 'returns C_COMMAND otherwise' do
      p = Parser.new(StringIO.new("M = D + 1\n"))
      p.advance
      expect(p.command_type).to eq('C_COMMAND')
    end
  end

  describe '#symbol' do
    it 'returns the number' do
      p = Parser.new(StringIO.new("@100\n"))
      p.advance
      expect(p.symbol).to eq('100')
    end

    it 'handles negative numbers' do
      p = Parser.new(StringIO.new("@-1\n"))
      p.advance
      expect(p.symbol).to eq('-1')
    end

    it 'returns the referenced symbol' do
      p = Parser.new(StringIO.new("@LOOP\n"))
      p.advance
      expect(p.symbol).to eq('LOOP')
    end
  end

  describe '#jump' do
    it 'returns nothing for no jump' do
      p = Parser.new(StringIO.new("M = D + 1\n"))
      p.advance
      expect(p.jump).to eq('')
    end

    it 'returns JGT' do
      p = Parser.new(StringIO.new("M = D + 1;JGT\n"))
      p.advance
      expect(p.jump).to eq('JGT')
    end

    it 'returns JEQ' do
      p = Parser.new(StringIO.new("M = D + 1;JEQ\n"))
      p.advance
      expect(p.jump).to eq('JEQ')
    end

    it 'returns JGE' do
      p = Parser.new(StringIO.new("M = D + 1;JGE\n"))
      p.advance
      expect(p.jump).to eq('JGE')
    end

    it 'returns JLT' do
      p = Parser.new(StringIO.new("M = D + 1;JLT\n"))
      p.advance
      expect(p.jump).to eq('JLT')
    end

    it 'returns JNE' do
      p = Parser.new(StringIO.new("M = D + 1;JNE\n"))
      p.advance
      expect(p.jump).to eq('JNE')
    end

    it 'returns JLE' do
      p = Parser.new(StringIO.new("M = D + 1;JLE\n"))
      p.advance
      expect(p.jump).to eq('JLE')
    end

    it 'returns JMP' do
      p = Parser.new(StringIO.new("M = D + 1;JMP\n"))
      p.advance
      expect(p.jump).to eq('JMP')
    end
  end

  describe '#dest' do
    it 'returns the M destination' do
      p = Parser.new(StringIO.new("M = D + 1\n"))
      p.advance
      expect(p.dest).to eq('M')
    end

    it 'returns the A destination' do
      p = Parser.new(StringIO.new("A = D + 1\n"))
      p.advance
      expect(p.dest).to eq('A')
    end

    it 'returns the D destination' do
      p = Parser.new(StringIO.new("D = A + 1\n"))
      p.advance
      expect(p.dest).to eq('D')
    end

    it 'returns the AD destination' do
      p = Parser.new(StringIO.new("AD = A + 1\n"))
      p.advance
      expect(p.dest).to eq('AD')
    end

    it 'returns the MD destination' do
      p = Parser.new(StringIO.new("MD = A + 1\n"))
      p.advance
      expect(p.dest).to eq('MD')
    end

    it 'returns the AM destination' do
      p = Parser.new(StringIO.new("AM = A + 1\n"))
      p.advance
      expect(p.dest).to eq('AM')
    end

    it 'returns all 3' do
      p = Parser.new(StringIO.new("AMD = D + 1\n"))
      p.advance
      expect(p.dest).to eq('AMD')
    end

    it 'returns none' do
      p = Parser.new(StringIO.new("D + 1\n"))
      p.advance
      expect(p.dest).to eq('')
    end
  end
end
