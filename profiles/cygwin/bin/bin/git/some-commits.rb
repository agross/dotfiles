#!/usr/bin/env ruby
require 'fileutils'

count = ARGV.shift || 1

def file_name(int)
  "Datei-#{int}.txt"
end

count.to_i.times.each do |c|
  begin
    r = (rand() * 100).to_i
    f = file_name(r)
  end while File.exist?(f)

  system "touch #{f}"
  system "git add --all"
  system "git commit -m 'Commitnachricht #{f}'"
end
