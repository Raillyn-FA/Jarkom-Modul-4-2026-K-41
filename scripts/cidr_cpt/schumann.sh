enable
configure terminal
hostname Schumann
no ip domain-lookup
interface FastEthernet0/0
 description A3 ke Switch2 (segmen bersama)
 ip address 10.84.24.140 255.255.255.248
 no shutdown
 exit
interface FastEthernet0/1
 description A7 ke Akashic
 ip address 10.84.12.1 255.255.255.248
 no shutdown
 exit
interface FastEthernet1/0
 description A8 ke Accela
 ip address 10.84.12.9 255.255.255.252
 no shutdown
 exit
ip route 10.84.8.0 255.255.252.0 10.84.12.10
ip route 0.0.0.0 0.0.0.0 10.84.24.137
end
write memory