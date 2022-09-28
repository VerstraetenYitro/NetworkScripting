add-computer –domainname "intranet.mijnschool.be"  -restart

Enable-PSRemoting -Force

Enter-PSSession win11-dc2

Install-ADDSDomainController -InstallDns -DomainName "intranet.mijnschool.be"