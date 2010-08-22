require 'rake'
require 'configatron'

class String
	def in(dir)
		File.join(dir, self)
	end
	
	def to_absolute
		File.expand_path(self)
	end
	
	def winpath
		self.gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)
	end
end

task :load_config do
	configatron.configure_from_yaml 'config.yml'
	
	puts "\nWe will use the following configuration:"
	puts configatron.inspect
	puts "\n"
end

desc "Let's hook this motherfucker into your system"
task :install => :load_config do
	homes = Dir.glob("*/")
	
	homes.map! {|x| x.chop! }.each do |home|
		if configatron.homes.exists?(home.to_sym)
			install_to = [] << configatron.homes.method_missing(home.to_sym).to_s
		else
			install_to = configatron.homes.configatron_keys.map { |h| configatron.homes.method_missing(h.to_sym).to_s }
		end
		
		process_home home, install_to
	end
end

def process_home(home, install_to)
	puts ">>> Linking '#{home}' to #{install_to.join(', ')}"

	linkables = Dir.glob("#{home}/*/*")
	linkables.each do |linkable|
		if File.basename(linkable).match /bin/
			destination = "bin"
		else
			destination = ".#{File.basename(linkable)}"
		end
		
		install_to.each do |targetdir|
			symlink_file linkable, destination.in(targetdir)
		end
	end
end

@@password = nil

def admin_password
	@@password ||= (print "Please enter the password for #{configatron.admin}: "; STDIN.gets.chomp)
end

@@replace_all = false

def symlink_file(linkable, destination)
	linkable = linkable.to_absolute.winpath
	destination = destination.to_absolute.winpath
	puts "Linking #{linkable} -> #{destination}"
	
	if File.exist?(destination)
		if File.identical? linkable, destination
			puts "Identical #{destination}"
			return
		elsif @@replace_all
			replace_file linkable, destination
		else
			print "Overwrite #{destination}? [ynaq] "
			case $stdin.gets.chomp
				when 'a'
					@@replace_all = true
					replace_file linkable, destination
				when 'y'
					replace_file linkable, destination
				when 'q'
					exit
				else
					puts "Skipping #{destination}"
			end
		end
	else
		link_file linkable, destination
	end
end

def replace_file(linkable, destination)
	rm_rf destination
	link_file linkable, destination
end

def link_file(linkable, destination)
	mkdir_p File.dirname(destination), { :verbose => false }
	
	as_admin configatron.admin, admin_password do
		command = [] << "cmd" << "/c" << "mklink" 
		command << "/d" if File.directory?(linkable)
		command << destination << linkable
	end
end

def as_admin(user, password)
	command = yield if block_given?
		
	psexec = %w{ psexec.exe -e -u } << user << "-p" << password
	sh *(psexec + command)
end