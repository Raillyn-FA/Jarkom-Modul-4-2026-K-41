#!/bin/sh

# eth0 -> Switch8 (A13 = 10.84.13.0/24), gateway = Navi
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.13.3/24 dev eth0
ip route replace default via 10.84.13.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route