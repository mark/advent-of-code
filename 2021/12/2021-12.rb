input = File.readlines('./2021-12-input.txt').map(&:chomp)

Map = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  lhs, rhs = *line.split('-')

  Map[lhs] << rhs
  Map[rhs] << lhs
end

small_rooms = Map.keys.select { |room| room == room.downcase && room != 'start' && room != 'end' }
puts "Found #{ small_rooms.length } small rooms"

successful_paths = []

small_rooms.each do |blessed|
  active_paths = [ ['start'] ]

  while active_paths.any?
    path = active_paths.pop
    last = path[-1]

    if last == 'end'
      successful_paths << path
    else
      Map[last].each do |room|
        if room == room.upcase
          active_paths << path + [room]
        elsif room == blessed && path.count(room) < 2
          active_paths << path + [room]
        elsif ! path.include?(room)
          active_paths << path + [room]
        end
      end
    end
  end
end

successful_paths.uniq!.sort!
# successful_paths.each { |path| puts path.join(',') }
puts "Found #{ successful_paths.length } paths"