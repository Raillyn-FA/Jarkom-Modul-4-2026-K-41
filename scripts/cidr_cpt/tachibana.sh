enable
configure terminal
hostname Tachibana
no ip domain-lookup
interface FastEthernet0/0
 description A14 ke Wired
 ip address 10.84.24.134 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A15 ke Switch9
 ip address 10.84.20.1 255.255.254.0
 no shutdown
 exit
interface FastEthernet1/0
 description A16 ke Deus
 ip address 10.84.22.133 255.255.255.252
 no shutdown
 exit
ip route 10.84.22.0 255.255.254.0 10.84.22.134
ip route 0.0.0.0 0.0.0.0 10.84.24.133
end
write memory