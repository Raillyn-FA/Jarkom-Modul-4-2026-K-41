#!/bin/sh

# Alamat IP interface
# eth0 -> Switch2
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.36/29 dev eth0
# eth1 -> langsung ke Akashic
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.16.41/29 dev eth1
# eth2 -> langsung ke Accela
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.61/30 dev eth2

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.33
ip route replace 10.84.4.0/22 via 10.84.16.62

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route