enable
configure terminal
hostname Knights
no ip domain-lookup
interface FastEthernet0/0
 description A20 ke Protocol7
 ip address 10.84.23.66 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A21 ke Eiri
 ip address 10.84.23.169 255.255.255.248
 no shutdown
 exit
interface FastEthernet1/0
 description A22 ke Phantoma
 ip address 10.84.23.165 255.255.255.252
 no shutdown
 exit
ip route 10.84.23.128 255.255.255.128 10.84.23.166
ip route 0.0.0.0 0.0.0.0 10.84.23.65
end
write memory
