$computerName = "win11-DC1"
$installingRolesNames = "AD-Domain-Services","DHCP","DNS" #to get list of all roles run "Get-WindowsFeature"
$credential="administrator"
$domainCredential="$env:USERDOMAIN\$credential"



#control if roles are already installed, if not install the role.


$alreadyInstalled = Get-WindowsFeature -Name $installingRolesNames[$i - 1] | % Installed
if(-not $alreadyInstalled)
{
    Install-WindowsFeature -Name $installingRolesNames[$i - 1] -computerName $computerName -IncludeManagementTools -Restart
} 




# Create New Forest, add Domain Controller
$domainname = “intranet.mijnschool.be”
$netbiosName = “mijnschool”
Install-ADDSForest -DomainName "$domainname" -InstallDNS


#add DC
Install-ADDSDomainController -InstallDns -Credential $credential -DomainName $domainname
