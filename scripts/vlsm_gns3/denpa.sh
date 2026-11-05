#!/bin/sh

# eth0 -> Switch5 (A9 = 10.84.4.0/22), gateway = Accela
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.4.3/22 dev eth0
ip route replace default via 10.84.4.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route