# scp with rsync for ESXi
# https://damiendebin.net/blog/2013/12/06/esxi-5-dot-1-and-rsync/
# Cipher selection: http://blog.famzah.net/2010/06/11/openssh-ciphers-performance-benchmark/
alias scpe="rsync -vv --partial --progress --rsh='ssh -T -c aes128-ctr -o Compression=no -x' --rsync-path=/vmfs/volumes/568907fe-071195ba-011b-001517f84ff0/bin/rsync"
