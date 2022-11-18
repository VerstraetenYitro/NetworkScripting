#!/bin/bash
sudo apt install isc-dhcp-server -y 



while IFS="," read -r networkAddress netmask firstIp LastIP
do
  echo "subnet $networkAddress netmask $netmask {" >> /etc/dhcp/dhcpd.conf
  echo "  range $firstIp $LastIP;" >> /etc/dhcp/dhcpd.conf
  echo "}" >> /etc/dhcp/dhcpd.conf
  echo "" >> /etc/dhcp/dhcpd.conf
done < <(tail -n +2 subnets.csv)


sudo systemctl restart isc-dhcp-server.service