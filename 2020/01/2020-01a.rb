require 'set'

f = File.readlines('./2020-01-input.csv').map(&:to_i)

s = Set.new(f)

s.each do |i|
  if s.include?(2020-i)
    puts "#{i}\t#{2020-i}\t#{i * (2020-i)}"
  end
end