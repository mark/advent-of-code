require './helpers'

input = File.readlines('./2021-14-sample.txt')

current = input[0].strip.split('')
rules = Hash.new

input[2..-1].each do |line|
  if line =~ /([A-Z])([A-Z]) -> ([A-Z])/
    rules[[$1,$2]] = $3
  else
    raise "I don't understand '#{line}'"
  end
end

puts "Template: #{current.join }"

10.times do |i|
  newpoly = [current[0]]

  current.window(2).each do |a,b|
    # puts "a = #{a}, b = #{b}, rule = #{rules[[a,b]]}"
    newpoly << rules[[a,b]] << b
  end

  current = newpoly.compact
  puts "After step #{i+1}"
end

counts = Hash.new { |h, k| h[k] = 0 }
current.each { |char| counts[char] += 1 }

diff = counts.values.max - counts.values.min

puts "Difference = #{ diff }"