enable
configure terminal
hostname Phantoma
no ip domain-lookup
interface FastEthernet0/0
 description A22 ke Knights
 ip address 10.84.23.166 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A23 ke Switch12
 ip address 10.84.23.129 255.255.255.224
 no shutdown
 exit
interface FastEthernet1/0
 description A24 ke Shibuya
 ip address 10.84.23.161 255.255.255.252
 no shutdown
 exit
ip route 10.84.23.192 255.255.255.192 10.84.23.162
ip route 0.0.0.0 0.0.0.0 10.84.23.165
end
write memory