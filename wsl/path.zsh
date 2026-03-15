if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version; then
  # Get rid of Windows binaries in PATH.
  # Remove all PATHs starting with /mnt/.
  path=(${path##/mnt/*})
  # Remove all PATHs starting with single char like a drive letter, e.g. /c/foo.
  path=(${path##/?/*})
fi
