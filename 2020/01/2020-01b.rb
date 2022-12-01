require 'set'

f = File.readlines('./2020-01-input.csv').map(&:to_i)

s = Set.new(f)

s.each do |i|
  s.each do |j|
    k = i + j
    if s.include?(2020-k)
      puts "#{i}\t#{j}\t#{2020-k}\t#{i * j * (2020-k)}"
    end
  end
end