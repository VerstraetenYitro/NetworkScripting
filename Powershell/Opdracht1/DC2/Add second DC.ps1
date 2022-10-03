$computerName = "win11-DC2"
$credential="administrator"
$domainCredential="$env:INTRANET\$credential"
$domainname = “intranet.mijnschool.be”
$netbiosName = “mijnschool”
$netadapter = Get-NetAdapter -Name "Ethernet0"

Enter-PSSession win11-dc2

#control if roles are already installed, if not install the role.


$alreadyInstalled = Get-WindowsFeature -Name "AD-Domain-Services" | % Installed
if(-not $alreadyInstalled)
{
    Install-WindowsFeature -Name "AD-Domain-Services" -computerName $computerName -IncludeManagementTools -Restart
} 


#set DNS correct
$netadapter | Set-DNSClientServerAddress -ServerAddress ("192.168.1.3","192.168.1.2")


#Install-ADDSDomainController -InstallDns -Credential (Get-Credential -Credential $credential) -DomainName $domainname -Confirm

#Install-ADDSDomainController -InstallDns -DomainName $domainname 

Install-ADDSDomainController -InstallDns -Credential (Get-Credential) -DomainName $domainname