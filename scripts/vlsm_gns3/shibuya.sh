#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Phantoma
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.90/30 dev eth0
# eth1 -> Switch13
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.15.193/26 dev eth1

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.89

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route