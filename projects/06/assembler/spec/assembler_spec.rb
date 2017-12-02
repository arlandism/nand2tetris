require_relative '../assembler'

describe Assembler do
  context 'without symbol resolution' do
    describe 'add program' do
      it 'translates' do
        assembly = StringIO.new("@2\n"\
                                "D=A\n"\
                                "@3\n"\
                                "D=D+A\n"\
                                "@0\n"\
                                "M=D")
        output = %w(
        0000000000000010
        1110110000010000
        0000000000000011
        1110000010010000
        0000000000000000
        1110001100001000
        )
        expect(described_class.new(assembly).run).to eq(output)
      end
    end

    describe 'max program' do
      it 'translates' do
        assembly = StringIO.new(
          "@0\n"\
          "D=M\n"\
          "@1\n"\
          "D=D-M\n"\
          "@10\n"\
          "D;JGT\n"\
          "@1\n"\
          "D=M\n"\
          "@12\n"\
          "0;JMP\n"\
          "@0\n"\
          "D=M\n"\
          "@2\n"\
          "M=D\n"\
          "@14\n"\
          "0;JMP"
        )
        output = %w(
        0000000000000000
        1111110000010000
        0000000000000001
        1111010011010000
        0000000000001010
        1110001100000001
        0000000000000001
        1111110000010000
        0000000000001100
        1110101010000111
        0000000000000000
        1111110000010000
        0000000000000010
        1110001100001000
        0000000000001110
        1110101010000111
        )
        expect(described_class.new(assembly).run).to eq(output)
      end
    end
  end

  context 'with symbol resolution' do
    describe 'max program' do
      it 'translates' do
        assembly = StringIO.new('@R0'\
                                'D=M              // D = first number'\
                                '@R1'\
                                'D=D-M            // D = first number - second number'\
                                '@OUTPUT_FIRST'\
                                'D;JGT            // if D>0 (first is greater) goto output_first'\
                                '@R1'\
                                'D=M              // D = second number'\
                                '@OUTPUT_D'\
                                '0;JMP            // goto output_d'\
                                '(OUTPUT_FIRST)'\
                                '@R0'\
                                'D=M              // D = first number'\
                                '(OUTPUT_D)'\
                                '@R2'\
                                'M=D              // M[2] = D (greatest number)'\
                                '(INFINITE_LOOP)'\
                                '@INFINITE_LOOP'\
                                '0;JMP            // infinite loop')
        output = %w(
        0000000000000000
        1111110000010000
        0000000000000001
        1111010011010000
        0000000000001010
        1110001100000001
        0000000000000001
        1111110000010000
        0000000000001100
        1110101010000111
        0000000000000000
        1111110000010000
        0000000000000010
        1110001100001000
        0000000000001110
        1110101010000111
        )
        expect(described_class.new(assembly).run).to eq(output)
      end
    end
  end
end
