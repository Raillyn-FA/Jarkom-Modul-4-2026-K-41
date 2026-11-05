#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Wired
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.70/30 dev eth0
# eth1 -> Switch9
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.10.1/23 dev eth1
# eth2 -> langsung ke Deus
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.73/30 dev eth2

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.69
ip route replace 10.84.14.128/25 via 10.84.16.74
ip route replace 10.84.15.128/25 via 10.84.16.74
ip route replace 10.84.16.0/27 via 10.84.16.74
ip route replace 10.84.16.48/29 via 10.84.16.74
ip route replace 10.84.16.76/30 via 10.84.16.74
ip route replace 10.84.16.80/29 via 10.84.16.74
ip route replace 10.84.16.88/30 via 10.84.16.74

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route