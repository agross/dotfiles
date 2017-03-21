if [[ "$OS" != "Windows_NT" ]]; then
  alias paket='mono ./.paket/paket.exe'
else
  alias paket='./.paket/paket.exe'
fi
