#!/bin/sh

# eth0 -> langsung ke Copland (A5 = 10.84.15.0/26), gateway = Copland
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.15.2/26 dev eth0
ip route replace default via 10.84.15.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route