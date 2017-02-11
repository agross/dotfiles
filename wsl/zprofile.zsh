if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version && \
   [[ "$(umask)" == '000' ]]; then
  umask 022
fi
