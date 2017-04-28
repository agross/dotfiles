if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version; then
  # Remove all PATHs starting with /mnt/ to get rid of Windows binaries in PATH.
  path=(${path##/mnt/*})
fi
