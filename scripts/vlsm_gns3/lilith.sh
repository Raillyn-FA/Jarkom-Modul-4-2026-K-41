#!/bin/sh

# eth0 -> Switch10 (A17 = 10.84.14.128/25), gateway = Deus
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.14.130/25 dev eth0
ip route replace default via 10.84.14.129
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route