#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Cyberia
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.58/30 dev eth0
# eth1 -> Switch2
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.16.33/29 dev eth1
# eth2 -> langsung ke Tachibana
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.69/30 dev eth2
# eth3 -> langsung ke Navi
ip link set eth3 up
ip addr flush dev eth3
ip addr add 10.84.16.65/30 dev eth3

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.57            # ke atas via Cyberia
ip route replace 10.84.0.0/22 via 10.84.16.34       # via Psyche (A4)
ip route replace 10.84.8.0/23 via 10.84.16.35       # via Copland (A6)
ip route replace 10.84.15.0/26 via 10.84.16.35      # via Copland (A5)
ip route replace 10.84.4.0/22 via 10.84.16.36       # via Schumann (A9)
ip route replace 10.84.16.40/29 via 10.84.16.36     # via Schumann (A7)
ip route replace 10.84.16.60/30 via 10.84.16.36     # via Schumann (A8)
ip route replace 10.84.12.0/23 via 10.84.16.66      # via Navi (A11, A13)
ip route replace 10.84.15.64/26 via 10.84.16.66     # via Navi (A12)
ip route replace 10.84.10.0/23 via 10.84.16.70      # via Tachibana (A15)
ip route replace 10.84.14.128/25 via 10.84.16.70    # via Tachibana (A17)
ip route replace 10.84.15.128/25 via 10.84.16.70    # via Tachibana (A19, A25)
ip route replace 10.84.16.0/27 via 10.84.16.70      # via Tachibana (A23)
ip route replace 10.84.16.48/29 via 10.84.16.70     # via Tachibana (A21)
ip route replace 10.84.16.72/29 via 10.84.16.70     # via Tachibana (A16, A18)
ip route replace 10.84.16.80/29 via 10.84.16.70     # via Tachibana (A20, A22)
ip route replace 10.84.16.88/30 via 10.84.16.70     # via Tachibana (A24)

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route