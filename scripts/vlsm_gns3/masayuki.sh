#!/bin/sh

# eth0 -> Switch4 (A6 = 10.84.8.0/23), gateway = Copland
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.8.2/23 dev eth0
ip route replace default via 10.84.8.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route