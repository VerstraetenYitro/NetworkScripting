$computerName = "win11-DC1"
$installingRolesNames = "AD-Domain-Services","DHCP","DNS" #to get list of all roles run "Get-WindowsFeature"
$credential="administrator"
$domainCredential="$env:INTRANET\$credential"
$domainname = “intranet.mijnschool.be”
$netbiosName = “mijnschool”



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

#add DC
Install-ADDSDomainController -InstallDns -Credential (Get-Credential -Credential $credential) -DomainName $domainname -Confirm

#Install-ADDSDomainController -InstallDns -DomainName $domainname 
