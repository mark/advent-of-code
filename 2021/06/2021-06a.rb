f = File.readlines('./2021-06-sample.txt')[0].split(',').map(&:to_i)

def next_day(current)
  new_fish = []

  current.map do |n|
    if n == 0
      new_fish << 8
      6
    else
      n - 1
    end
  end + new_fish
end

puts "Initial state: #{f.join ','} (#{f.length} fish)"

18.times do |i|
  f = next_day(f)
  # puts "After #{i+1} days: #{f.join ',' } (#{f.length} fish)"
  puts "After #{i+1} days: #{f.length} fish"
end
