#!/bin/sh

# eth0 -> Switch3 (A4 = 10.84.0.0/22), gateway = Psyche
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.0.2/22 dev eth0
ip route replace default via 10.84.0.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route