#!/bin/sh

# eth0 -> Switch9 (A15 = 10.84.10.0/23), gateway = Tachibana
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.10.3/23 dev eth0
ip route replace default via 10.84.10.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route