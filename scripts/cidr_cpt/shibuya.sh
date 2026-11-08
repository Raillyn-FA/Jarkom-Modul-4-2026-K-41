enable
configure terminal
hostname Shibuya
no ip domain-lookup
interface FastEthernet0/0
 description A24 ke Phantoma
 ip address 10.84.23.162 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A25 ke Switch13
 ip address 10.84.23.193 255.255.255.192
 no shutdown
 exit
ip route 0.0.0.0 0.0.0.0 10.84.23.161
end
write memory