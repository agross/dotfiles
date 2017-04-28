if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version; then
  [[ "$(umask)" == '000' ]] && umask 022

  # https://github.com/Microsoft/BashOnWindows/issues/1887
  unsetopt BG_NICE
fi
