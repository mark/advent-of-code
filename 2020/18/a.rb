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
      return accum
    when '+', '*'
      operator = current
    end
  end

  return accum
end

def evaluate(line)
  parsed = line.scan(/\d+|\s+|[+*()]/).reject { |str| str =~ /\s/ }.map { |str| str =~ /\d/ ? str.to_i : str }
  result = calculate(parsed)
  # puts parsed.inspect
  puts "Value = #{ result }"
  result
end

total = lines.map { |line| evaluate(line) }.sum

puts "Total sum = #{total}"