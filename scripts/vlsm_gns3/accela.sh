#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Schumann
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.62/30 dev eth0
# eth1 -> Switch5
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.4.1/22 dev eth1

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.61

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route