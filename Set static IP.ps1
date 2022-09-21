$netadapter = Get-NetAdapter -Name "Ethernet0"

$netadapter | Set-NetIPAddress -DHCP Disabled

$netadapter | New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.1.2 -PrefixLength 24 -DefaultGateway 192.168.1.1
$netadapter | Set-DnsClientDohServerAddress -ServerAddress ("172.20.4.140","172.20.4.141")

$netadapter | Get-NetIPAddress -AddressFamily IPv4 | ft
$netadapter | Get-NetRoute