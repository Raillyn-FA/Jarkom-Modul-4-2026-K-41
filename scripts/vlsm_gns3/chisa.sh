#!/bin/sh

# eth0 -> Switch11 (A19 = 10.84.15.128/26), gateway = Protocol7
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.15.130/26 dev eth0
ip route replace default via 10.84.15.129
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route