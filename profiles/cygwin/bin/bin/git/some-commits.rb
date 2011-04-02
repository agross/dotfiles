#!/usr/bin/env ruby
require 'fileutils'

count = ARGV.shift || 1

count.to_i.times.each do |c|
  begin
    r = (rand() * 100).to_i
  end while File.exist? r.to_s

  system "touch #{r}"
  system "git add --all"
  system "git commit -m #{r}"
end
