enable
configure terminal
hostname Navi
no ip domain-lookup
interface FastEthernet0/0
 description A10 ke Wired
 ip address 10.84.18.66 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A11 ke Switch6
 ip address 10.84.16.1 255.255.255.0
 no shutdown
 exit
interface FastEthernet1/0
 description A12 ke Switch7
 ip address 10.84.18.1 255.255.255.192
 no shutdown
 exit
interface FastEthernet1/1
 description A13 ke Switch8
 ip address 10.84.17.1 255.255.255.0
 no shutdown
 exit
ip route 0.0.0.0 0.0.0.0 10.84.18.65
end
write memory