class Parser
  JUMP_MAPPINGS = {
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111',
  }

  DEST_MAPPINGS = {
    'M' => '001',
    'D' => '010',
    'MD' => '011',
    'A' => '100',
    'AM' => '101',
    'AD' => '110',
    'AMD' => '111'
  }

  COMP_MAPPINGS = {
    '0' => '101010',
    '1' => '111111',
    '-1' => '111010',
    'D' => '001100',
    'A' => '110000',
    'M' => '110000',
    '!D' => '001101',
    '!A' => '110001',
    '!M' => '110001',
    '-D' => '001111',
    '-A' => '110011',
    '-M' => '110011',
    'D+1' => '011111',
    'A+1' => '110111',
    'M+1'  => '110111',
    'D-1' => '001110',
    'A-1' => '110010',
    'M-1' => '110010',
    'D+A' => '000010',
    'D+M' => '000010',
    'D-A' => '010011',
    'D-M' => '010011',
  }

  attr_reader :stream
  attr_accessor :current_line
  # input_file - open file stream
  def initialize(stream)
    @stream = stream
    @current_line = nil
  end

  def has_more_commands?
    stream.eof?
  end

  def advance
    @current_line = stream.readline.gsub(/\n/,'').gsub(/\s/,'')
  end

  def command_type
    case current_line[0]
    when '@'
      'A_COMMAND'
    when '('
      'L_COMMAND'
    else
      'C_COMMAND'
    end
  end

  def symbol
    current_line.split('@')[-1].to_i.to_s(2)
  end

  def dest
    destination_registers = current_line.split("=")[0]
    DEST_MAPPINGS.fetch(destination_registers, '000')
  end

  def comp
    if current_line.include?("=") && current_line.include?(";")
      comp_mnemonic = current_line.split("=")[1].split(";")[0]
    elsif current_line.include?("=")
      comp_mnemonic = current_line.split("=")[1].gsub(/\n/,'').strip
    elsif current_line.include?(";")
      comp_mnemonic = current_line.split(";")[0]
    end
    COMP_MAPPINGS.fetch(comp_mnemonic)
  end

  def jump
    jump_commands = current_line.split(";")[-1].gsub(/\n/,'').strip
    JUMP_MAPPINGS.fetch(jump_commands, '000')
  end

  private

  def normalize_end_of_line(eol)
    eol.gsub(/\n/,'').strip
  end
end
