start = nil
finish = nil

Zeros = []

Elevations = File.readlines(ARGV[0]).map { |str| str.chomp.split('') }.map.with_index do |line, y|
  line.map.with_index do |char, x|
    if char == 'S'
      start = [x, y]
      Zeros << [x, y]
      0
    elsif char == 'E'
      finish = [x, y]
      25
    else
      Zeros << [x, y] if char == 'a'
      char.ord - 'a'.ord
    end
  end
end

class Searcher

  def initialize(elevations, destination)
    @elevations = elevations
    @destination = destination
    @height = @elevations.length
    @width = @elevations[0].length
  end

  def visit(from, dx, dy, steps)
    x = from[0] + dx
    y = from[1] + dy
    to = [x, y]

    return unless x >= 0 && x < @width && y >= 0 && y < @height
    return unless @elevations[y][x] - @elevations[from[1]][from[0]] <= 1

    unless @steps.include?(to)
      @active << to
      @steps[to] = steps + 1
    end
  end

  def search(start)
    @steps   = { start => 0 }
    @active  = [ start ]

    while @active.any? && ! @steps.include?(@destination)  
      current = @active.shift
      steps   = @steps[current]

      visit(current,  1,  0, steps)
      visit(current, -1,  0, steps)
      visit(current,  0,  1, steps)
      visit(current,  0, -1, steps)
    end

    return @steps[@destination]
  end
end

puts "There are #{Zeros.length} possible starting locations"

searcher = Searcher.new(Elevations, finish)
# steps_req = searcher.search(start)
steps_req = Zeros.map { |z| print '.'; searcher.search(z) }.compact.min

# puts Steps.inspect
puts "Steps required = #{steps_req}"
