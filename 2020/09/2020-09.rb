lines = File.readlines("./2020-09-input.txt").map(&:to_i)

PREAMBLE = 25

def is_valid?(current, previous)
  previous.each do |a|
    previous.each do |b|
      return true if a != b && (a + b) == current
    end
  end
  false
end

def find_invalid(sequence)
  (sequence.length-PREAMBLE).times do |i|
    previous = sequence[i, PREAMBLE]
    current = sequence[i+PREAMBLE]
    unless is_valid?(current, previous)
      puts "#{current} is INVALID"
      return current
    end
  end
end

def find_sum_to_from(sequence, sum, index)
  (sequence.length-index).times do |j|
    subseq = sequence[index, j]
    return subseq if subseq.sum == sum
    return nil if subseq.sum > sum
  end
  nil
end

def find_sum_to(sequence, sum)
  sequence.length.times do |i|
    subseq = find_sum_to_from(sequence, sum, i)

    if subseq
      puts "#{subseq.join(' + ')} = #{sum}"
      return subseq
    end
  end
end

invalid = find_invalid(lines)
subseq = find_sum_to(lines, invalid)

puts "Min = #{subseq.min}\tMax = #{subseq.max}\tCombined = #{subseq.min + subseq.max}"
