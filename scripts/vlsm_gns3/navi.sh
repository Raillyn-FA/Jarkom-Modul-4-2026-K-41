#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Wired
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.66/30 dev eth0
# eth1 -> Switch6
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.12.1/24 dev eth1
# eth2 -> Switch7
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.15.65/26 dev eth2
# eth3 -> Switch8
ip link set eth3 up
ip addr flush dev eth3
ip addr add 10.84.13.1/24 dev eth3

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.65

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route