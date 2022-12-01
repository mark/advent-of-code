f = File.readlines('./2021-06-input.txt')[0].split(',').map(&:to_i)

UPDATE = [
#  0  1  2  3  4  5  6  7  8  
  [0, 1, 0, 0, 0, 0, 0, 0, 0], # => 0
  [0, 0, 1, 0, 0, 0, 0, 0, 0], # => 1
  [0, 0, 0, 1, 0, 0, 0, 0, 0], # => 2
  [0, 0, 0, 0, 1, 0, 0, 0, 0], # => 3
  [0, 0, 0, 0, 0, 1, 0, 0, 0], # => 4
  [0, 0, 0, 0, 0, 0, 1, 0, 0], # => 5
  [1, 0, 0, 0, 0, 0, 0, 1, 0], # => 6
  [0, 0, 0, 0, 0, 0, 0, 0, 1], # => 7
  [1, 0, 0, 0, 0, 0, 0, 0, 0], # => 8
]

def dot(as, bs)
  (0...as.length).inject(0) { |sum, i| sum + as[i] * bs[i] }
end

def next_day(current)
  (0..8).map { |i| dot(current, UPDATE[i]) }
end

puts "Initial state: #{f.join ','} (#{f.length} fish)"
current = (0..8).map { |i| f.count(i) }

  puts "After 0 days: #{current.sum} fish (#{current.join ',' })"

256.times do |i|
  current = next_day(current)
  puts "After #{i+1} days: #{current.sum} fish (#{current.join ',' })"
end
