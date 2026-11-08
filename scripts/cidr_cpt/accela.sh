enable
configure terminal
hostname Accela
no ip domain-lookup
interface FastEthernet0/0
 description A8 ke Schumann
 ip address 10.84.12.10 255.255.255.252
 no shutdown
 exit
interface FastEthernet0/1
 description A9 ke Switch5
 ip address 10.84.8.1 255.255.252.0
 no shutdown
 exit
ip route 0.0.0.0 0.0.0.0 10.84.12.9
end
write memory