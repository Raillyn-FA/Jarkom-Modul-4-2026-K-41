enable
configure terminal
hostname Protocol7
no ip domain-lookup
interface FastEthernet0/0
 description A18 ke Deus
 ip address 10.84.22.130 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A19 ke Switch11
 ip address 10.84.23.1 255.255.255.192
 no shutdown
 exit
interface FastEthernet1/0
 description A20 ke Knights
 ip address 10.84.23.65 255.255.255.252
 no shutdown
 exit
ip route 10.84.23.128 255.255.255.128 10.84.23.66
ip route 0.0.0.0 0.0.0.0 10.84.22.129
end
write memory