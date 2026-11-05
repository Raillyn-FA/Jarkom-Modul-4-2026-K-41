#!/bin/sh

# eth0 -> NAT (DHCP dari GNS3 NAT)
ip link set eth0 up
if command -v udhcpc >/dev/null 2>&1; then
    udhcpc -i eth0 -n -q >/dev/null 2>&1
elif command -v dhclient >/dev/null 2>&1; then
    dhclient eth0 >/dev/null 2>&1
fi

ip -4 addr show dev eth0 | grep -q 'inet ' || ip addr add 192.168.122.2/24 dev eth0
GW=$(ip route | awk '/^default/ {print $3; exit}')
[ -z "$GW" ] && GW=192.168.122.1
ip route replace default via "$GW" dev eth0
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Alamat IP interface
# eth1 -> Switch1
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.14.1/25 dev eth1
# eth2 -> langsung ke Wired
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.57/30 dev eth2

# IP forwarding 
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing 
ip route replace 10.84.0.0/19 via 10.84.16.58      

# NAT
if ! command -v iptables >/dev/null 2>&1; then
    if command -v apk >/dev/null 2>&1; then apk add --no-cache iptables
    elif command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y iptables
    fi
fi
iptables -t nat -C POSTROUTING -o eth0 -s 10.84.0.0/19 -j MASQUERADE 2>/dev/null || \
iptables -t nat -A POSTROUTING -o eth0 -s 10.84.0.0/19 -j MASQUERADE

# Cek hasil 
ip addr | grep "inet "
ip route