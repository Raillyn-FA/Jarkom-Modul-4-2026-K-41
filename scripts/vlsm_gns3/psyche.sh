#!/bin/sh

# Alamat IP interface
# eth0 -> Switch3 (A4 = 10.84.0.0/22)
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.0.1/22 dev eth0
# eth1 -> Switch2 (A3 = 10.84.16.32/29)
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.16.34/29 dev eth1

# IP forwarding (wajib agar router meneruskan paket)
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.33

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route