
# convert integers up to 2^15 into binary
# to a 15 bit width
# returns a string of characters
class Binary
  class << self
    def convert(number)
      number = number.to_i
      14.downto(0).map {|n| number[n] }.join
    end
  end
end
