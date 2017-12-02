current_dir = File.expand_path(__FILE__)
$LOAD_PATH << current_dir
require_relative 'assembler'

asm_file = ARGV[0]
input_file = File.open(File.expand_path(asm_file)) do |input|
  assembler = Assembler.new(input)
  dir_tokens = asm_file.split("/")
  src_dir = File.join(*dir_tokens[0...-1])
  assembly_output_filename = "#{dir_tokens[-1].split(".")[0]}-gen2.hack"
  target_dir = File.expand_path(src_dir)
  File.open(File.join(src_dir, assembly_output_filename), "w+") do |output|
    output << assembler.run.join("\n")
  end
end
