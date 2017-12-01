current_dir = File.expand_path(__FILE__)
$LOAD_PATH << current_dir
require_relative 'parser'
require_relative 'symbol_table'
require_relative 'code'

asm_file = ARGV[0]
input_file = File.open(File.join(current_dir, asm_file)) do |input|
  assembler = Assembler.new(input)
  assembly_output_filename = "#{asm_file.split(".")[0]}.hack"
  File.open(File.join(current_dir, assembly_output_filename)) do |output|
    output << assembler.run.join("\n")
  end
end
