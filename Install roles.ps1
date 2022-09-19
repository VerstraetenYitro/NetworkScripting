
$computerName = "win11-DC1"
$installingRolesNames = "DHCP","DNS","AD-Domain-Services" #to get list of all roles run "Get-WindowsFeature"


#control if roles are already installed, if not install the role.

for($i = 0;$i -le $installingRolesNames.Length;$i++)
{
    $alreadyInstalled = Get-WindowsFeature -Name $installingRolesNames[$i - 1] | % Installed
    if(-not $alreadyInstalled)
    {
        Install-WindowsFeature -Name $installingRolesNames[$i - 1] -computerName $computerName
    }
       
}
 
 