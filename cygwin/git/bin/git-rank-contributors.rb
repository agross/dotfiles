#!/usr/bin/env ruby

## git-rank-contributors: a simple script to trace through the logs and
## rank contributors by the total size of the diffs they're responsible for.
## A change counts twice as much as a plain addition or deletion.
##
## Output may or may not be suitable for inclusion in a CREDITS file.
## Probably not without some editing, because people often commit from more
## than one address.
##
## git-rank-contributors Copyright 2008 William Morgan <wmorgan-git-wt-add@masanjin.net>. 
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or (at
## your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You can find the GNU General Public License at:
##   http://www.gnu.org/licenses/

class String
  def obfuscate; gsub(/@/, " at the ").gsub(/\.(\w+)(>|$)/, ' dot \1s\2') end
  def htmlize; gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;") end
end

authors = Hash.new

obfuscate = ARGV.delete("-o")
htmlize = ARGV.delete("-h")
by_commits = ARGV.delete("-commits")

author = nil
state = :pre_author
`git log -M -C -C -p --no-color`.each do |l|
  case
  when (state == :pre_author || state == :post_author) && l =~ /Author: (.*)$/
    author = $1
    state = :post_author
	authors[author] ||= Hash.new(0)
	authors[author][:commits] += 1
  when state == :post_author && l =~ /^\+\+\+/
    state = :in_diff
  when state == :in_diff && l =~ /^[\+\-]/
    authors[author][:lines] += 1
  when state == :in_diff && l =~ /^commit /
    state = :pre_author
  end
end

sorter = lambda { |data| data[:lines] }
sorter = lambda { |data| data[:commits] } if by_commits

longest_name = authors.keys.collect { |key| key.length }.max
longest_commits = authors.values.collect{ |data| data[:commits].to_s.length }.max
longest_diffs = authors.values.collect{ |data| data[:lines].to_s.length }.max

authors.sort_by { |author, data| -1 * sorter.call(data) }.each do |author, data|
  author = author.obfuscate if obfuscate
  author = author.htmlize if htmlize
  
  puts "#{author.rjust(longest_name)}: #{data[:commits].to_s.rjust(longest_commits)} commits with #{data[:lines].to_s.rjust(longest_diffs)} lines of diff"
end