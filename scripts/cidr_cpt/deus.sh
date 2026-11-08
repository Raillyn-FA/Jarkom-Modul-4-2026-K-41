enable
configure terminal
hostname Deus
no ip domain-lookup
interface FastEthernet0/0
 description A16 ke Tachibana
 ip address 10.84.22.134 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A17 ke Switch10
 ip address 10.84.22.1 255.255.255.128
 no shutdown
 exit
interface FastEthernet1/0
 description A18 ke Protocol7
 ip address 10.84.22.129 255.255.255.252
 no shutdown
 exit
ip route 10.84.23.0 255.255.255.0 10.84.22.130
ip route 0.0.0.0 0.0.0.0 10.84.22.133
end
write memory
