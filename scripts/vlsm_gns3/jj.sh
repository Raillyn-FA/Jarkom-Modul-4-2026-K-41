#!/bin/sh

# eth0 -> Switch1 (A1 = 10.84.14.0/25), gateway = Cyberia
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.14.2/25 dev eth0
ip route replace default via 10.84.14.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route