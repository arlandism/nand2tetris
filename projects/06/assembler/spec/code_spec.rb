require_relative '../code'

# I decided to test this because there are a small enough
# number of cases that it sort of made sense to do so. Although,I'm just fetching from a hash table so I'm not sure if this is worth the effort.

describe Code do
  describe '#dest' do
    it 'returns the M destination' do
      expect(Code.dest('M')).to eq('001')
    end

    it 'returns the A destination' do
      expect(Code.dest('A')).to eq('100')
    end

    it 'returns the D destination' do
      expect(Code.dest('D')).to eq('010')
    end

    it 'returns the AD destination' do
      expect(Code.dest('AD')).to eq('110')
    end

    it 'returns the MD destination' do
      expect(Code.dest('MD')).to eq('011')
    end

    it 'returns the AM destination' do
      expect(Code.dest('AM')).to eq('101')
    end

    it 'returns all 3' do
      expect(Code.dest('AMD')).to eq('111')
    end

    it 'returns none' do
      expect(Code.dest('')).to eq('000')
    end
  end

  describe '#jump' do
    it 'returns all zeroes for no jump' do
      expect(Code.jump("")).to eq('000')
    end

    it 'returns JGT' do
      expect(Code.jump("JGT")).to eq('001')
    end

    it 'returns JEQ' do
      expect(Code.jump("JEQ")).to eq('010')
    end

    it 'returns JGE' do
      expect(Code.jump("JGE")).to eq('011')
    end

    it 'returns JLT' do
      expect(Code.jump("JLT")).to eq('100')
    end

    it 'returns JNE' do
      expect(Code.jump("JNE")).to eq('101')
    end

    it 'returns JLE' do
      expect(Code.jump("JLE")).to eq('110')
    end

    it 'returns JMP' do
      expect(Code.jump("JMP")).to eq('111')
    end
  end
end
