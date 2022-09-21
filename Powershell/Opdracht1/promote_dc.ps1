$computerName = "win11-DC1"
$installingRolesNames = "AD-Domain-Services","DHCP","DNS" #to get list of all roles run "Get-WindowsFeature"


try
{
#control if roles are already installed, if not install the role.

    for($i = 0;$i -le $installingRolesNames.Length;$i++)
    {
        $alreadyInstalled = Get-WindowsFeature -Name $installingRolesNames[$i - 1] | % Installed
        if(-not $alreadyInstalled)
        {
            Install-WindowsFeature -Name $installingRolesNames[$i - 1] -computerName $computerName -IncludeManagementTools -Restart
        } 
    }
}
catch
{}


# Create New Forest, add Domain Controller
$domainname = “nwtraders.msft”
$netbiosName = “NWTRADERS”
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false `
-DatabasePath “C:\Windows\NTDS” `
-DomainMode “Win2012” `
-DomainName $domainname `
-DomainNetbiosName $netbiosName `
-ForestMode “Win2012” `
-InstallDns:$true `
-LogPath “C:\Windows\NTDS” `
-NoRebootOnCompletion:$false `
-SysvolPath “C:\Windows\SYSVOL” `
-Force:$true