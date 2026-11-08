enable
configure terminal
hostname Copland
no ip domain-lookup
interface FastEthernet0/0
 description A3 ke Switch2 (segmen bersama)
 ip address 10.84.24.139 255.255.255.248
 no shutdown
 exit
interface FastEthernet0/1
 description A5 ke Juri
 ip address 10.84.6.1 255.255.255.192
 no shutdown
 exit
interface FastEthernet1/0
 description A6 ke Switch4
 ip address 10.84.4.1 255.255.254.0
 no shutdown
 exit
ip route 0.0.0.0 0.0.0.0 10.84.24.137
end
write memory
