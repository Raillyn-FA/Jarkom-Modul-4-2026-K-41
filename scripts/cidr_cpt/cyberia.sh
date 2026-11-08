enable
configure terminal
hostname Cyberia
no ip domain-lookup
interface FastEthernet0/0
 description ke Cloud0 (tanpa IP)
 no shutdown
 exit
interface FastEthernet0/1
 description A1 ke Switch1
 ip address 10.84.24.1 255.255.255.128
 no shutdown
 exit
interface FastEthernet1/0
 description A2 ke Wired
 ip address 10.84.24.129 255.255.255.252
 no shutdown
 exit
ip route 10.84.0.0 255.255.224.0 10.84.24.130
end
write memory