if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version; then
  # Remove all PATHs starting with /mnt/ to get rid of Windows binaries in PATH.
  path=(${path##/mnt/*})
  # Remove all Dropbox PATHs.
  path=(${path##/d/Dropbox/*})
  # Remove all Cygwin PATHs.
  path=(${path##/c/Cygwin/*})
  # Remove npm from PATH.
  path=(${path##/c/Users/${USER}/AppData/Roaming/npm})
fi
