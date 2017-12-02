require_relative './parser'
require_relative './code'
require_relative './binary'
require_relative './symbol_table'

class Assembler

  attr_reader :parser, :output, :assembly_stream

  def initialize(assembly_stream)
    @assembly_stream = assembly_stream
    @parser = Parser.new(assembly_stream)
    @output = []
  end

  def run
    symbol_table = SymbolTable.new
    current_rom_address = 0
    current_ram_address = 16
    while parser.has_more_commands?
      parser.advance
      case parser.command_type
      when "L_COMMAND"
        symbol_table.add_entry(parser.symbol, current_rom_address)
      else
        current_rom_address += 1
      end
    end

    assembly_stream.rewind

    while parser.has_more_commands?
      parser.advance
      binary = case parser.command_type
               when "A_COMMAND"
                 if parser.symbol.match(/^\d+$/)
                   "0#{Binary.convert(parser.symbol)}"
                 elsif symbol_table.has_entry?(parser.symbol)
                   "0#{Binary.convert(symbol_table.resolve(parser.symbol))}"
                 else
                   addr = current_ram_address
                   current_ram_address += 1
                   symbol_table.add_entry(parser.symbol, addr)
                   "0#{Binary.convert(addr)}"
                 end
               when "C_COMMAND"
                 "111#{Code.comp(parser.comp)}#{Code.dest(parser.dest)}#{Code.jump(parser.jump)}"
               when "L_COMMAND"
                 next
               end

      output << binary
    end
    output
  end
end
