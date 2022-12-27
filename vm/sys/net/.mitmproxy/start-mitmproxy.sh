#!/bin/sh
modprobe nft_counter
modprobe nft_masq
modprobe nft_redir
nft add table ip nat
nft -- add chain ip nat prerouting { type nat hook prerouting priority -100 \; }
nft add rule ip nat prerouting tcp dport 80 redirect to :8080
nft add rule ip nat prerouting tcp dport 443 redirect to :8080

#nft add table ip mitm_ipv4
#nft add chain ip mitm_ipv4 c { type nat hook output priority 0 \; }
#nft add rule ip mitm_ipv4 c tcp dport 80 redirect to :8080
#nft add rule ip mitm_ipv4 c tcp dport 443 redirect to :8080
