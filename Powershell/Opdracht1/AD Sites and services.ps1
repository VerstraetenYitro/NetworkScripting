$newSiteName="Kortrijk"
$computerName = "win11-DC1"

#rename default-first-site-name site

Rename-ADObject -Identity "CN=default-first-site-name,CN=Sites,CN=Configuration,DC=intranet,DC=mijnschool,DC=be" -NewName $newSiteName

#install dhcp
$role="DHCP"
$alreadyInstalled = Get-WindowsFeature -Name $role | % Installed
if(-not $alreadyInstalled)
    {
        Install-WindowsFeature -Name $role -computerName $computerName -IncludeManagementTools -Restart
    }

#add subnet to site
New-ADReplicationSubnet -Name "192.168.1.0/24" -Site $newSiteName -Location "Kortrijk,Belgium"

#create UPN suffix
Get–ADForest | Set–ADForest –UPNSuffixes @{add=“mijnschool.be”}