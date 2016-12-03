#!/usr/bin/env ruby

head, threshold = ARGV
head ||= 'HEAD'
Megabyte = 1000 ** 2
threshold = (threshold || 0.1).to_f * Megabyte

big_files = {}

puts "Inspecting commits reachable via %s, threshold %.1fMB" % [head, threshold / Megabyte]

IO.popen("git rev-list #{head}", 'r') do |rev_list|
  rev_list.each_line do |commit|
    print '.'

    commit.chomp!
    for object in `git ls-tree -zr --long #{commit}`.split("\0")
      _bits, _type, sha, size, path = object.split(/\s+/, 5)
      size = size.to_i
      big_files[sha] = [path, size, commit] if size >= threshold
    end
  end

  puts "\nDone inspecting commits"
end

if big_files.any?
  big_files
    .sort_by { |_sha, (_path, size, _commit)| size }
    .reverse
    .each do |sha, (path, size, commit)|
    where = `git show -s #{commit} --format='%h: %cr'`.chomp
    puts "%4.1fMB\t%s\t(%s)" % [size.to_f / Megabyte, path, where]
  end
else
  puts "No files bigger than %.1fMB found" % [threshold / Megabyte]
end
