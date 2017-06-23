if [[ "$OS" != Windows* ]]; then
  alias paket='mono ./.paket/paket.exe'
else
  alias paket='./.paket/paket.exe'
fi
