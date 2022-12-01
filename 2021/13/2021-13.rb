require 'set'
input = File.readlines("./2021-13-input.txt")

Points = []
Folds = []

input.each do |line|
  if line =~ /(\d+),(\d+)/
    Points << [$1.to_i, $2.to_i]
  elsif line =~ /fold along (x|y)=(\d+)/
    Folds << [$1, $2.to_i]
  end
end

puts "Found #{Points.length} points and #{Folds.length} folds."

def fold1d(before, fold_at)
  before > fold_at ? fold_at - (before - fold_at) : before
end

def fold_point(point, fold)
  x, y = *point
  if fold[0] == 'x' # horizontal fold
    [fold1d(x, fold[1]), y]
  else # vertical fold
    [x, fold1d(y, fold[1])]
  end
end

final_points = Points.map do |point|
  Folds.inject(point) { |folded, fold| fold_point(folded, fold) }
end.uniq

maxx = final_points.map { |x, y| x }.max
maxy = final_points.map { |x, y| y }.max

(0..maxy).each do |y|
  (0..maxx).each do |x|
    print final_points.include?([x, y]) ? '#' : ' '
  end
  puts
end
