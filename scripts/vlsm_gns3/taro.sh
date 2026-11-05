#!/bin/sh

# eth0 -> Switch7 (A12 = 10.84.15.64/26), gateway = Navi
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.15.66/26 dev eth0
ip route replace default via 10.84.15.65
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route