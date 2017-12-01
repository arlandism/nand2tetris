require_relative './parser'

class Assembler

  attr_reader :parser, :output

  def initialize(assembly_stream)
    @parser = Parser.new(assembly_stream)
    @output = []
  end

  def run
    while parser.has_more_commands?
      parser.advance
      binary = case parser.command_type
               when "A_COMMAND"
                 "0#{parser.symbol}"
               when "C_COMMAND"
                 "111#{parser.comp}#{parser.dest}#{parser.jump}"
               when "L_COMMAND"
               end

      output << binary
    end
    output
  end
end
