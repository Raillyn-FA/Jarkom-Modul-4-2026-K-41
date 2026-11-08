enable
configure terminal
hostname Psyche
no ip domain-lookup
interface FastEthernet0/0
 description A4 ke Switch3
 ip address 10.84.0.1 255.255.252.0
 no shutdown
 exit
interface FastEthernet0/1
 description A3 ke Switch2 (segmen bersama)
 ip address 10.84.24.138 255.255.255.248
 no shutdown
 exit
ip route 0.0.0.0 0.0.0.0 10.84.24.137
end
write memory