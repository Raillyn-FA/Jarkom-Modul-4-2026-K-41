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