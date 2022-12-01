require './helpers'

input = File.readlines('./2021-14-input.txt')

template = input[0].strip.split('')
rules = Hash.new { |h, k| h[k] = [] }

input[2..-1].each do |line|
  if line =~ /([A-Z])([A-Z]) -> ([A-Z])/
    rules["#{$1}#{$2}"] = ["#{$1}#{$3}", "#{$3}#{$2}"]
  else
    raise "I don't understand '#{line}'"
  end
end

current = Hash.new { |h,k| h[k] = 0 }
template.window(2).each { |a, b| current["#{a}#{b}"] += 1 }

puts current.inspect

40.times do |i|
  newpoly = Hash.new { |h, k| h[k] = 0 }

  current.each do |pair, count|
    rules[pair].each do |newpair|
      newpoly[newpair] += count
    end
  end

  current = newpoly
end

counts = Hash.new { |h, k| h[k] = 0 }
current.each { |pair, count| counts[pair[1]] += count }
counts[template[0]] += 1 # The initial character never changes, need to count it

diff = counts.values.max - counts.values.min

puts "Difference = #{ diff }"