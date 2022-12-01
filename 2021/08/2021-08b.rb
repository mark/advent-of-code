require 'set'
input = File.readlines('./2021-08-input.txt')

AllChars = %w(A B C D E F G)
DownChars = AllChars.map(&:downcase)

Segments = [
  Set.new(["A", "B", "C",      "E", "F", "G"]), # 0  6
  Set.new([          "C",           "F"     ]), # 1  2
  Set.new(["A",      "C", "D", "E",      "G"]), # 2  5  *
  Set.new(["A",      "C", "D",      "F", "G"]), # 3  5  *
  Set.new([     "B", "C", "D",      "F"     ]), # 4  4
  Set.new(["A", "B",      "D",      "F", "G"]), # 5  5  *
  Set.new(["A", "B",      "D", "E", "F", "G"]), # 6  6
  Set.new(["A",      "C",           "F"     ]), # 7  3
  Set.new(["A", "B", "C", "D", "E", "F", "G"]), # 8  7
  Set.new(["A", "B", "C", "D",      "F", "G"])  # 9  6
]

def digit_for_segments(segments)
  Segments.each_with_index do |set, index|
    return index if set == segments
  end
  return -1
end

def print_mapping(mapping)
  DownChars.each do |bad|
    goods = AllChars.map { |good| mapping[bad].include?(good) ? good : " " }
    puts "#{bad} => #{goods.join }"
  end
end

def resolve_mapping(mapping, from)
  good_char = mapping[from].first
  to_resolve = []

  mapping.each do |bad, goods|
    if bad != from && goods.include?(good_char) # to is still a possible mapping
      goods.delete(good_char) # Get rid of to
      to_resolve << bad if goods.length == 1 # Propogate
    end
  end

  to_resolve.each { |new_from| resolve_mapping(mapping, new_from) }
end

def reduce_possibilities(mapping, from_segments, to_segments)
  DownChars.each do |from|
    possibles = mapping[from]
    if from_segments.include?(from)
      possibles &= to_segments
    else
      possibles -= to_segments
    end
    mapping[from] = possibles

    resolve_mapping(mapping, from) if possibles.length == 1
  end

end

def can_map?(mapping, from_segments, to_segments)
  from_segments.all? { |from| (mapping[from] & to_segments).any? }
end

def possible_mappings(mapping)
  # can't decide between CF, BD, EG
end

# Gets a set of 10 segments, maps bad segments (lower case) to good segments (upper case)
def determine_mapping(segments)
  mapping = Hash.new { |h, k| h[k] = Set.new("ABCDEFG".split('')) }

  # puts "After 1:"
  is_1 = segments.find { |segs| segs.length == 2 }
  reduce_possibilities(mapping, is_1, Segments[1])
  # print_mapping(mapping)
  # puts

  # puts "After 4:"
  is_4 = segments.find { |segs| segs.length == 4 }
  reduce_possibilities(mapping, is_4, Segments[4])
  # print_mapping(mapping)
  # puts

  # puts "After 7:"
  is_7 = segments.find { |segs| segs.length == 3 }
  reduce_possibilities(mapping, is_7, Segments[7])
  # print_mapping(mapping)
  # puts

  five_segs = segments.select { |segs| segs.length == 5 }

  # puts "After 3:"
  is_cf = mapping.select { |from, tos| tos.include?("C") && tos.include?("F") }.keys
  is_3 = five_segs.find { |segs| (segs & is_cf).length == 2 }
  reduce_possibilities(mapping, is_3, Segments[3])
  # print_mapping(mapping)
  # puts

  # puts "After 2:"
  is_b = mapping.find { |from, tos| tos.include?("B") }[0]
  is_2 = five_segs.find { |segs| segs != is_3 && ! segs.include?(is_b) }
  reduce_possibilities(mapping, is_2, Segments[2])
  # print_mapping(mapping)
  # puts

  Hash.new.tap do |good_map|
    DownChars.each { |char| good_map[char] = mapping[char].first }
  end
end

total = input.map do |line|
  samples, output = *line.split(' | ').map { |chars| chars.split(' ').map { |segs| segs.split('') } }

  mapping = determine_mapping(samples)

  output.map do |outs|
    outset = Set.new(outs.map { |bad| mapping[bad] })
    digit = digit_for_segments(outset)

    # puts "#{outs.join } => #{ digit }"
  end.join.to_i
end.sum

puts "TOTAL = #{ total }"