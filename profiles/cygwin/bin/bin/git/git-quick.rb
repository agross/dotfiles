#!/usr/bin/env ruby

USAGE = <<EOH
Usage: git-quick [add|new|rm|checkout|head] index [, index, ...]

Where index is the line number in the output of `git status`, starting at 1.
The index starts at 1 for each of the "changes to be committed",
"changed but not updated" and "untracked files" sections.
EOH

$operations = {
  :add         => { :match => /^.M/,         :cmd => 'git add --'},
  :new         => { :match => /^\?\?/,       :cmd => 'git add --'},
  :rm          => { :match => /^ D/,         :cmd => 'git rm --'},
  :checkout    => { :match => /^.M/,         :cmd => 'git checkout --'},
  :head        => { :match => /^(.M|M |A )/, :cmd => 'git reset HEAD --'},
  :diff        => { :match => /^.M/,         :cmd => 'git diff --'},
  :diff_cached => { :match => /^(M|A)./,     :cmd => 'git diff --cached --'}
}

def find_operation(command)
  $operations[command.to_sym]
end

class String
  def escape
    "\"#{self.to_s}\""
  end
end

if ARGV.delete("--help") || ARGV.delete("-h")
  puts USAGE
  exit
end
					
$op = find_operation ARGV.shift
$dry_run = ARGV.delete("--dry-run") || ARGV.delete("-n")
$indexes = ARGV.map do |index| index.to_i - 1 end

files = %x{ git status -s } \
  .split(/[\r\n]+/) \
  .grep($op[:match]) \
  .values_at(*($indexes)) \
  .map do |line|
    line.sub($op[:match], "").strip.escape + " "
  end
  
cmd = "#{$op[:cmd]} #{files}"

if $dry_run
	puts "Would execute:\n#{cmd}"
	exit
end

system cmd