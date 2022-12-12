require 'pp'
history = File.readlines('./input.txt').map(&:chomp)

Root = { contents: {} }
Root[:parent] = Root

pwd = nil

history.each do |line|
  if line =~ /\$ cd \.\./
    pwd = pwd[:parent]
  elsif line =~ /\$ cd \//
    pwd = Root
  elsif line =~ /\$ cd (.+)/
    pwd = pwd[:contents][$1]
  elsif line =~ /\$ ls/
    # puts "list"
  elsif line =~ /dir (.+)/
    pwd[:contents][$1] = { parent: pwd, contents: {} }
  elsif line =~ /(\d+) (.+)/
    pwd[:contents][$2] = { size: $1.to_i }
  else
    puts "I don't understand #{line}"
  end
end

def walk_tree(dir, &block)
  dir[:contents].each_value do |file|
    walk_tree(file, &block) if file[:contents]
  end

  yield(dir)
end

small_dir_total = 0

walk_tree(Root) do |dir|
  dir[:size] = dir[:contents].map { |name, file| file[:size] }.sum

  small_dir_total += dir[:size] if dir[:size] <= 100000
end

puts "Small dir total = #{small_dir_total}"
