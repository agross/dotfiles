if (( $+commands[systemctl] )); then
  verbose Setting up $fg[red]systemd$reset_color aliases

  alias sc=systemctl
  alias scs='systemctl status'
  alias sca='systemctl start'
  alias sco='systemctl stop'
  alias scr='systemctl restart'
  alias scf='systemctl --failed'
  alias jf='journalctl --since="1 hour ago" --unit'
fi
