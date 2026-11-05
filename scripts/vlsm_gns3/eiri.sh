#!/bin/sh

# eth0 -> langsung ke Knights (A21 = 10.84.16.48/29), gateway = Knights
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.50/29 dev eth0
ip route replace default via 10.84.16.49
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route