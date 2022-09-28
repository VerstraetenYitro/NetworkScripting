#add reverse lookup zone
Add-DnsServerPrimaryZone -NetworkID “192.168.1.0/24” -ReplicationScope "Forest"

Register-DnsClient #ipconfig /registerdns

#disable ipv6
Disable-NetAdapterBinding -InterfaceAlias "Ethernet0" -ComponentID ms_tcpip6