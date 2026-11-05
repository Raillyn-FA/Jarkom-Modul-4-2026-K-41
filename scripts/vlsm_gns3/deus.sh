#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Tachibana
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.74/30 dev eth0
# eth1 -> Switch10
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.14.129/25 dev eth1
# eth2 -> langsung ke Protocol7
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.77/30 dev eth2

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.73
ip route replace 10.84.15.128/25 via 10.84.16.78
ip route replace 10.84.16.0/27 via 10.84.16.78
ip route replace 10.84.16.48/29 via 10.84.16.78
ip route replace 10.84.16.80/29 via 10.84.16.78
ip route replace 10.84.16.88/30 via 10.84.16.78

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route