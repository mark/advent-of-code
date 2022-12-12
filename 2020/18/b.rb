lines = File.readlines('./2020-18-input.txt').map(&:chomp)
# lines = File.readlines('./sample.txt').map(&:chomp)

def operate(lhs, operator, rhs)
  case operator
  when '+' then lhs + rhs
  when '*' then lhs * rhs
  else nil
  end
end

def calculate(symbols)
  addends = []
  operator = nil
  accum = nil

  while symbols.any?
    case current = symbols.shift
    when Integer
      if operator
        accum = operate(accum, operator, current)
        operator = nil
      else
        accum = current
      end
    when '('
      value = calculate(symbols)
      if operator
        accum = operate(accum, operator, value)
        operator = nil
      else
        accum = value
      end
    when ')'
      addends << accum
      return addends.inject(:*)
    when '*'
      addends << accum
      accum = nil
    when '+'
      operator = current
    end
  end

  addends << accum
  return addends.inject(:*)
end

def evaluate(line)
  parsed = line.scan(/\d+|\s+|[+*()]/).reject { |str| str =~ /\s/ }.map { |str| str =~ /\d/ ? str.to_i : str }
  result = calculate(parsed.dup)
  puts parsed.inspect
  puts "Value = #{ result }"
  result
end

total = lines.map { |line| evaluate(line) }.sum

puts "Total sum = #{total}"