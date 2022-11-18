#!/bin/bash

sudo apt install apache2 bind9 -y

sed -i '/OPTIONS/d' /etc/default/bind9

echo 'OPTIONS="-u bind -4"' >> /etc/default/bind9

echo "" > /etc/bind/named.conf.options
echo "options {" >> /etc/bind/named.conf.options
echo '  directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo '  dnssec-validation auto;' >> /etc/bind/named.conf.options
echo '  version "not currently available";' >> /etc/bind/named.conf.options
echo '  recursion yes;' >> /etc/bind/named.conf.options
echo '  allow-recursion { 127.0.0.1; 192.168.1.0/24; };' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options


echo 'zone "yitro.be" {' >> /etc/bind/named.conf.local
echo '  type master;' >> /etc/bind/named.conf.local
echo '  file "/etc/bind/zones/db.yitro.be";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local

echo 'zone "1.168.192.in-addr.arpa" {' >> /etc/bind/named.conf.local
echo '  type master;' >> /etc/bind/named.conf.local
echo '  file "/etc/bind/zones/db.192.168";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local

sudo mkdir /etc/bind/zones

touch /etc/bind/zones/db.yitro.be

echo ';' >> /etc/bind/zones/db.yitro.be
echo '$TTL    604800' >> /etc/bind/zones/db.yitro.be
echo '@       IN      SOA     yitro.be. root.yitro.be. (' >> /etc/bind/zones/db.yitro.be
echo '                             14         ; Serial' >> /etc/bind/zones/db.yitro.be
echo '                         604800         ; Refresh' >> /etc/bind/zones/db.yitro.be
echo '                          86400         ; Retry' >> /etc/bind/zones/db.yitro.be
echo '                        2419200         ; Expire' >> /etc/bind/zones/db.yitro.be
echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/zones/db.yitro.be
echo '' >> /etc/bind/zones/db.yitro.be
echo ';' >> /etc/bind/zones/db.yitro.be
echo '@               IN      NS      yitro.be.' >> /etc/bind/zones/db.yitro.be
echo '' >> /etc/bind/zones/db.yitro.be
echo ';' >> /etc/bind/zones/db.yitro.be
echo '@               IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be
echo '' >> /etc/bind/zones/db.yitro.be
echo ';' >> /etc/bind/zones/db.yitro.be
echo 'www             IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be
echo 'mail            IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be
echo 'www.mail        IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be
echo 'mailadmin       IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be
echo 'www.mailadmin   IN      A       192.168.1.124' >> /etc/bind/zones/db.yitro.be


touch /etc/bind/zones/db.192.168

echo ';' >> /etc/bind/zones/db.192.168
echo '$TTL    604800' >> /etc/bind/zones/db.192.168
echo '@       IN      SOA     yitro.be. root.yitro.be. (' >> /etc/bind/zones/db.192.168
echo '                              15        ; Serial' >> /etc/bind/zones/db.192.168
echo '                         604800         ; Refresh' >> /etc/bind/zones/db.192.168
echo '                          86400         ; Retry' >> /etc/bind/zones/db.192.168
echo '                        2419200         ; Expire' >> /etc/bind/zones/db.192.168
echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/zones/db.192.168
echo '' >> /etc/bind/zones/db.192.168
echo ';' >> /etc/bind/zones/db.192.168
echo '@               IN      NS      yitro.be.' >> /etc/bind/zones/db.192.168
echo '@               IN      A       192.168.1.124' >> /etc/bind/zones/db.192.168


sudo systemctl restart named