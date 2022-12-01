require 'set'
f = File.readlines('./2021-04-input.txt')

class Board
  attr_reader :turn, :score
  def initialize(rows)
    @rows = rows
    @lines = lines_for(rows)
    @all = Set.new(rows.flatten)
  end

  def print
    puts '+' + '-' * 14 + '+'
    @rows.each { |row| puts '|' + row.map { |c| c.to_s.rjust(2) }.join(' ') + '|' } 
    puts '+' + '-' * 14 + '+'
  end

  def lines_for(rows)
    lines = []
    5.times do |i|
      row = Set.new
      col = Set.new

      5.times do |j|
        row << rows[i][j]
        col << rows[j][i]
      end

      lines << row << col
    end
    lines
  end

  def score_board(called, last, turn)
    @turn = turn
    @score = if @lines.any? { |line| line <= called }
      last * (@all - called).sum
    else
      0
    end
  end

end

def score_board(calls, board)
  called = Set.new
  calls.each_with_index do |call, index|
    called << call
    score = board.score_board(called, call, index)
    return index, score if score > 0
  end
  # return (calls.length+1), 0
end

boards = []
calls = f[0].split(',').map(&:to_i)
f = f[1..-1]

while f.length > 5
  rows = f[1,5]
  f = f[6..-1]
  parsed = rows.map { |r| r.strip.split(/\s+/).map(&:to_i) }
  boards << Board.new(parsed)
end

boards.each do |board|
  turn, score = score_board(calls, board)
end

puts "WINNER:"
winner = boards.sort_by { |b| [b.turn, b.score] }.first
winner.print
puts "BINGO on turn #{winner.turn}, score = #{winner.score}"

puts
puts "LOSER:"
loser = boards.sort_by { |b| [b.turn, b.score] }.last
loser.print
puts "BINGO on turn #{loser.turn}, score = #{loser.score}"
