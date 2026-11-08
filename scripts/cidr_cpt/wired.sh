enable
configure terminal
hostname Wired
no ip domain-lookup
interface FastEthernet0/0
 description A2 ke Cyberia
 ip address 10.84.24.130 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A14 ke Tachibana
 ip address 10.84.24.133 255.255.255.252
 no shutdown
 exit
interface FastEthernet1/0
 description A10 ke Navi
 ip address 10.84.18.65 255.255.255.252
 no shutdown
 exit
interface FastEthernet1/1
 description A3 ke Switch2 (segmen bersama)
 ip address 10.84.24.137 255.255.255.248
 no shutdown
 exit
ip route 10.84.0.0 255.255.252.0 10.84.24.138
ip route 10.84.4.0 255.255.252.0 10.84.24.139
ip route 10.84.8.0 255.255.248.0 10.84.24.140
ip route 10.84.16.0 255.255.252.0 10.84.18.66
ip route 10.84.20.0 255.255.252.0 10.84.24.134
ip route 0.0.0.0 0.0.0.0 10.84.24.129
end
write memory
