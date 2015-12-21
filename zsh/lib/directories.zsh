# If a command is issued that can't be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Any parameter that is set to the absolute name of a directory immediately becomes a name for that directory, that will be used by the `%~' and related prompt sequences, and will be available when completion is performed on a word starting with `~'. (Otherwise, the parameter must be used in the form `~param' first.)
setopt auto_name_dirs

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups
