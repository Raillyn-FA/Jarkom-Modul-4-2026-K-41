#!/bin/sh

# eth0 -> Switch12 (A23 = 10.84.16.0/27), gateway = Phantoma
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.2/27 dev eth0
ip route replace default via 10.84.16.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route