lines = File.readlines('./input.txt').map(&:chomp)

overlap = lines.count do |line|
  if line =~ /(\d+)-(\d+),(\d+)-(\d+)/
    min1, max1, min2, max2 = [$1, $2, $3, $4].map(&:to_i)

    (min1 >= min2 && max1 <= max2) || (min2 >= min1 && max2 <= max1)
  else
    puts "I don't understand #{line}"
  end
end

puts "Found #{overlap} overlapping assignments"