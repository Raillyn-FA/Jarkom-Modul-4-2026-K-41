#!/bin/sh

# eth0 -> Switch13 (A25 = 10.84.15.192/26), gateway = Shibuya
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.15.194/26 dev eth0
ip route replace default via 10.84.15.193
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route