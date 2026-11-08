# Jarkom-Modul-4-2026-K-41

|         Nama         |     NRP     |
|----------------------|-------------|
|Aliya Rahmadina       | 5027251056  |
|Rayhan Fadhilah Allayn| 5027251126  |

## Laporan
[SPREADSHEET](K-41_Spreadsheet%20Modul%204%20Komdat%20Jarkom%202026.xlsx)

Pada "Serial Experiments Lain, Layer 04: The Wired Expansion", jaringan The Wired diperluas. Hanya router Cyberia yang terhubung ke dunia luar (NAT pada GNS3, Cloud pada CPT), lalu seluruh lalu lintas mengalir ke Wired yang bercabang ke Navi, Tachibana, dan satu segmen bersama Psyche, Copland, serta Schumann. Tugasnya adalah membagi alamat IP dan menyusun routing seefisien mungkin pada prefix `10.84.0.0` sehingga tidak ada alamat yang terbuang dan tidak ada entitas yang terisolasi. Topologi yang sama dikerjakan dua kali dengan metode classless yang berbeda.

## GNS3 - VLSM

### 1. Topologi GNS3
Topologi terdiri atas 13 router, 13 switch, 25 node (host/server), dan 1 node NAT
![topo](00-topologi-gns3-vlsm.png)

Setelah dianalisis, terdapat 25 subnet (A1 sampai A25). Berikut topologi dengan keterangan subnet:
![topo subnet](01-topologi-gns3-vlsm.png)

### 2. Total penggunaan subnet
Total subnet adalah 25 subnet, dengan total blok yang dialokasikan 4.188 IP. Karena 4.188 lebih besar dari 4.096 dan lebih kecil dari 8.192, pendekatan terkecil yang memuat seluruh jaringan adalah /19** (`10.84.0.0/19`). Detail perhitungan ada pada spreadsheet di atas.

Berikut VLSM tree-nya:
![alt text](02-vlsm-tree.png)

### 3. Command
**Cyberia** (`cyberia.sh`)

```
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
```

**Wired** (`wired.sh`)

```
#!/bin/sh

# Alamat IP interface
# eth0 -> langsung ke Cyberia
ip link set eth0 up
ip addr flush dev eth0
ip addr add 10.84.16.58/30 dev eth0
# eth1 -> Switch2
ip link set eth1 up
ip addr flush dev eth1
ip addr add 10.84.16.33/29 dev eth1
# eth2 -> langsung ke Tachibana
ip link set eth2 up
ip addr flush dev eth2
ip addr add 10.84.16.69/30 dev eth2
# eth3 -> langsung ke Navi
ip link set eth3 up
ip addr flush dev eth3
ip addr add 10.84.16.65/30 dev eth3

# IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1 || echo 1 > /proc/sys/net/ipv4/ip_forward

# Static routing
ip route replace default via 10.84.16.57            # ke atas via Cyberia
ip route replace 10.84.0.0/22 via 10.84.16.34       # via Psyche (A4)
ip route replace 10.84.8.0/23 via 10.84.16.35       # via Copland (A6)
ip route replace 10.84.15.0/26 via 10.84.16.35      # via Copland (A5)
ip route replace 10.84.4.0/22 via 10.84.16.36       # via Schumann (A9)
ip route replace 10.84.16.40/29 via 10.84.16.36     # via Schumann (A7)
ip route replace 10.84.16.60/30 via 10.84.16.36     # via Schumann (A8)
ip route replace 10.84.12.0/23 via 10.84.16.66      # via Navi (A11, A13)
ip route replace 10.84.15.64/26 via 10.84.16.66     # via Navi (A12)
ip route replace 10.84.10.0/23 via 10.84.16.70      # via Tachibana (A15)
ip route replace 10.84.14.128/25 via 10.84.16.70    # via Tachibana (A17)
ip route replace 10.84.15.128/25 via 10.84.16.70    # via Tachibana (A19, A25)
ip route replace 10.84.16.0/27 via 10.84.16.70      # via Tachibana (A23)
ip route replace 10.84.16.48/29 via 10.84.16.70     # via Tachibana (A21)
ip route replace 10.84.16.72/29 via 10.84.16.70     # via Tachibana (A16, A18)
ip route replace 10.84.16.80/29 via 10.84.16.70     # via Tachibana (A20, A22)
ip route replace 10.84.16.88/30 via 10.84.16.70     # via Tachibana (A24)

# DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Cek hasil
ip addr | grep "inet "
ip route
```

### 4. Verifikasi

Pengujian dilakukan dari Karl dengan `test_ping.sh`, yang melakukan ping ke seluruh host, seluruh antarmuka router, dan `8.8.8.8`, kemudian menguji DNS ke `google.com`.

**Karl** (`test_ping.sh`)
```
#!/bin/sh

ok=0; fail=0
while read name ip; do
    [ -z "$name" ] && continue
    if ping -c 1 -W 2 "$ip" >/dev/null 2>&1; then
        echo "OK    $name ($ip)"; ok=$((ok+1))
    else
        echo "FAIL  $name ($ip)"; fail=$((fail+1))
    fi
done <<EOF
Akashic 10.84.16.42
Alice 10.84.12.2
Chisa 10.84.15.130
Collective 10.84.10.2
Denpa 10.84.4.3
Eiri 10.84.16.50
Ghost 10.84.10.3
Hodgeson 10.84.15.131
JJ 10.84.14.2
Juri 10.84.15.2
Karl 10.84.0.2
Kuma 10.84.13.4
Lain 10.84.15.194
Lilith 10.84.14.130
Lin 10.84.0.3
Masayuki 10.84.8.2
Miho 10.84.13.3
Mika 10.84.15.195
MyuMyu 10.84.14.3
Omnipresence 10.84.4.2
Reika 10.84.12.3
Semi 10.84.16.2
Specter 10.84.14.131
Taro 10.84.15.66
Yasuo 10.84.13.2
Cyberia-eth1 10.84.14.1
Cyberia-eth2 10.84.16.57
Wired-eth0 10.84.16.58
Wired-eth1 10.84.16.33
Wired-eth2 10.84.16.69
Wired-eth3 10.84.16.65
Psyche-eth0 10.84.0.1
Psyche-eth1 10.84.16.34
Copland-eth0 10.84.15.1
Copland-eth1 10.84.16.35
Copland-eth2 10.84.8.1
Schumann-eth0 10.84.16.36
Schumann-eth1 10.84.16.41
Schumann-eth2 10.84.16.61
Accela-eth0 10.84.16.62
Accela-eth1 10.84.4.1
Navi-eth0 10.84.16.66
Navi-eth1 10.84.12.1
Navi-eth2 10.84.15.65
Navi-eth3 10.84.13.1
Tachibana-eth0 10.84.16.70
Tachibana-eth1 10.84.10.1
Tachibana-eth2 10.84.16.73
Deus-eth0 10.84.16.74
Deus-eth1 10.84.14.129
Deus-eth2 10.84.16.77
Protocol7-eth0 10.84.16.78
Protocol7-eth1 10.84.15.129
Protocol7-eth2 10.84.16.81
Knights-eth0 10.84.16.82
Knights-eth1 10.84.16.49
Knights-eth2 10.84.16.85
Phantoma-eth0 10.84.16.86
Phantoma-eth1 10.84.16.1
Phantoma-eth2 10.84.16.89
Shibuya-eth0 10.84.16.90
Shibuya-eth1 10.84.15.193
internet-8.8.8.8 8.8.8.8
EOF
echo "----"
echo "OK=$ok  FAIL=$fail"

# tes DNS + internet
ping -c 1 -W 3 google.com >/dev/null 2>&1 && echo "DNS/Internet: OK (google.com)" || echo "DNS/Internet: FAIL (google.com)"
```

![ping karl](03-ping-karl.png)