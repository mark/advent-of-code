require 'pp'
history = File.readlines('./input.txt').map(&:chomp)

TotalSpace    = 70000000
RequiredSpace = 30000000

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

def walk_tree(root, &block)
  root[:contents].each_value do |file|
    walk_tree(file, &block) if file[:contents]
  end

  yield(root)
end

walk_tree(Root) do |dir|
  dir[:size] = dir[:contents].map { |name, file| file[:size] }.sum
end

FreeSpace       = TotalSpace    - Root[:size]
RemainingToFree = RequiredSpace - FreeSpace

puts "Remaining Space to be freed = #{RemainingToFree}"

candidate = Root

walk_tree(Root) do |dir|
  if dir[:size] >= RemainingToFree && dir[:size] < candidate[:size]
    candidate = dir
  end
end

puts "Smallest dir large enough   = #{candidate[:size]}"