$computerName = "win11-DC1"
$installingRolesNames = "AD-Domain-Services","DHCP","DNS" #to get list of all roles run "Get-WindowsFeature"
$credential="administrator"
$domainCredential="$env:INTRANET\$credential"
$domainname = “intranet.mijnschool.be”
$netbiosName = “mijnschool”
$netadapter = Get-NetAdapter -Name "Ethernet0"



#control if roles are already installed, if not install the role.


$alreadyInstalled = Get-WindowsFeature -Name "AD-Domain-Services" | % Installed
if(-not $alreadyInstalled)
{
    Install-WindowsFeature -Name "AD-Domain-Services" -computerName $computerName -IncludeManagementTools -Restart
} 




# Create New Forest, add Domain Controller
if(Get-ADForest)
{
    Write-Host "forest already made"
}
else
{
    Install-ADDSForest -DomainName "$domainname" -DomainNetbiosName $netbiosName -InstallDNS
}

#set DNS correct
$netadapter | Set-DNSClientServerAddress -ServerAddress ("192.168.1.2","192.168.1.3")


#Install-ADDSDomainController -InstallDns -Credential (Get-Credential -Credential $credential) -DomainName $domainname -Confirm

#Install-ADDSDomainController -InstallDns -DomainName $domainname 

