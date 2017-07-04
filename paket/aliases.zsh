if [[ "$OS" != Windows* ]]; then
  alias paket='mono ./.paket/paket.exe'
else
  alias paket='./.paket/paket.exe'
fi

# Prefer executable in bin/ for Paket development.
zstyle ':completion::complete:paket:*' paket-executable './bin/paket.exe' './.paket/paket.exe'
