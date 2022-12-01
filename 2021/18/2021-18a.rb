class Singlet
  def initialize(num, depth)
    @num = num
    @depth = depth
  end

  def inspect
    "#{@num}@#{@depth}"
  end
end

class Pair
  def self.from_array(array, depth = 1, singlets = [])
    puts "Pair.from_array #{ array.inspect } @ #{depth}"
    if array.kind_of?(Integer)
      singlets << Singlet.new(array, depth-1)
    else
      Pair.new(Pair.from_array(array[0], depth+1, singlets), Pair.from_array(array[1], depth+1, singlets), depth)
    end
    singlets
  end

  def initialize(lhs, rhs, depth)
    @lhs = lhs
    @rhs = rhs
    @depth = depth
  end

  def inspect
    "<#{@lhs.inspect}, #{@rhs.inspect}>"
  end
end

file = ARGV[0] || 'input'
input = File.readlines("./2021-18-#{file}.txt").map { |str| Pair.from_array(eval(str)) }

input.each { |pair| puts pair.inspect }