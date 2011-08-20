#!/usr/bin/env ruby

USAGE = <<EOH
Usage: git-quick [add|new|rm|checkout|head] index [, index, ...]

Where index is the line number in the output of `git status`, starting at 1.
The index starts at 1 for each of the "changes to be committed",
"changed but not updated" and "untracked files" sections.
EOH

$operations = {
  :add               => { :match => /^.M/,         :cmd => %w{ git add -- } },
  :add_patch         => { :match => /^.M/,         :cmd => %w{ git add --patch -- } },
  :new               => { :match => /^\?\?/,       :cmd => %w{ git add -- } },
  :rm                => { :match => /^ D/,         :cmd => %w{ git rm -- } },
  :checkout          => { :match => /^.M/,         :cmd => %w{ git checkout -- } },
  :checkout_patch    => { :match => /^.M/,         :cmd => %w{ git checkout --patch -- } },
  :head              => { :match => /^(.M|M |A )/, :cmd => %w{ git reset HEAD -- } },
  :head_patch        => { :match => /^(.M|M |A )/, :cmd => %w{ git reset HEAD --patch -- } },
  :diff              => { :match => /^.M/,         :cmd => %w{ git diff -- } },
  :diff_cached       => { :match => /^(M|A)./,     :cmd => %w{ git diff --cached -- } }
}

def find_operation(command)
  $operations[command.to_sym]
end

if ARGV.delete("--help") || ARGV.delete("-h")
  puts USAGE
  exit
end
					
$op = find_operation ARGV.shift
$dry_run = ARGV.delete("--dry-run") || ARGV.delete("-n")
$indexes = ARGV.map { |spec| 
  if spec.include?('..')
    bounds = spec.split '..'
    (bounds[0].to_i..bounds[1].to_i).to_a
  else
    spec.to_i
  end
} \
.flatten \
.map! { |index|
  index - 1
}

files = %x{ git status -s } \
  .split(/[\r\n]+/) \
  .grep($op[:match]) \
  .values_at(*($indexes)) \
  .map do |line|
    line.sub($op[:match], "").strip 
  end

cmd = $op[:cmd] + files

if $dry_run
	puts "Would execute:\n#{cmd.join ' '}"
	exit
end

puts cmd.join ' '
system *(cmd)