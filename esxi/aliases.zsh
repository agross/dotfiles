# scp with rsync for ESXi
# http://blog.magiksys.net/run-rsync-in-server-mode-via-inetd-on-vmware-esxi
# Cipher selection: http://blog.famzah.net/2010/06/11/openssh-ciphers-performance-benchmark/
alias scpe="rsync --partial --progress --rsh='ssh -T -c blowfish-cbc -o Compression=no -x' --rsync-path=/vmfs/volumes/4cae2a76-9a623c13-67f0-002354056c3c/misc/sbin/rsync"
