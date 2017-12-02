class SymbolTable
  attr_accessor :entries
  def initialize
    @entries = {
      'SP' => 0,
      'R0' => 0,
      'LCL' => 1,
      'R1' => 1,
      'ARG' => 2,
      'R2' => 2,
      'THIS' => 3,
      'R3' => 3,
      'THAT' => 4,
      'R4' => 4,
      'R5' => 5,
      'R6' => 6,
      'R7' => 7,
      'R8' => 8,
      'R9' => 9,
      'R10' => 10,
      'R11' => 11,
      'R12' => 12,
      'R13' => 13,
      'R14' => 14,
      'R15' => 15,
      'SCREEN' => 16384,
      'KBD' => 24576
    }
  end

  def add_entry(key, val)
    entries[key] = val
  end

  def has_entry?(key)
    entries.include?(key)
  end

  def resolve(key)
    entries[key]
  end
end
