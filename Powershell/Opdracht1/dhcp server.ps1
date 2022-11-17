# authorize dhcp server
netsh DHCP add SecurityGroups

Add-DhcpServerInDC -DnsName Win11-DC1.intranet.mijnschool.be


#create dhcp server scope
Add-DhcpServerv4Scope -StartRange 192.168.1.1 -EndRange 192.168.1.254 -Name Kortrijk -SubnetMask 255.255.255.0 -State Active

#exclude ip addresses
Add-Dhcpserverv4ExclusionRange -ScopeId 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.10

#reserver IP for printer
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.25 -ClientId "b8-e9-37-3e-55-86" -Description "Reservation for Printer"