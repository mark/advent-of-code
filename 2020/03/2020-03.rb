raw = File.readlines('./2020-03-input.txt').map(&:strip)

Map = raw.map { |row| row.split('').map { |c| c == '#' } }

Map.each { |r| puts r.map { |s| s ? '#' : '.' }.join('') }

def is_tree?(x, y)
  Map[y][x % Map[y].length]
end

Slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

hit_trees = Slopes.map do |(dx, dy)|
  x = 0
  y = 0
  trees = 0

  while y < Map.length do
    # puts "Checking (#{x}, #{y}) -> #{ is_tree?(x, y) }"
    trees += 1 if is_tree?(x, y)
    x += dx
    y += dy
  end

  puts "Right #{dx}, down #{dy} - hit #{trees} trees"
  trees
end

product = hit_trees.inject(1) { |a, b| a * b }

puts "Product is #{ product }"