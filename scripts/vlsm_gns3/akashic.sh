#!/bin/sh

# eth0 -> langsung ke Schumann (A7 = 10.84.16.40/29), gateway = Schumann
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.42/29 dev eth0
ip route replace default via 10.84.16.41
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route