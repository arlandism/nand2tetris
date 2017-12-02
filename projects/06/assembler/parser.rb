class Parser
  attr_reader :stream
  attr_accessor :current_line, :dest, :comp, :jump
  # input_file - open file stream
  def initialize(stream)
    @stream = stream
    @current_line = nil
    @dest = ''
    @comp = ''
    @jump = ''
  end

  def has_more_commands?
    !stream.eof?
  end

  def advance
    @current_line = stream.readline.gsub(/\/\/.*\n/,'').gsub(/\s/,'')
    @dest = ''
    @comp = ''
    @jump = ''
    if current_line.empty?
      advance
    end

    if current_line.include?("=") && current_line.include?(";")
      @dest, rest = current_line.split("=")
      @comp, @jump = rest.split(";")
    elsif current_line.include?("=")
      @dest, @comp = current_line.split("=")
    elsif current_line.include?(";")
      @comp, @jump = current_line.split(";")
    end
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
    if command_type == 'A_COMMAND'
      current_line.split('@')[-1]
    elsif 'L_COMMAND'
      current_line.gsub('(','').gsub(')','')
    end
  end
end
