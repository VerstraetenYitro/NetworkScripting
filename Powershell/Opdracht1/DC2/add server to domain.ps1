#
# Making DC2 server member of the domain
#
$credential="administrator"
$domainCredential="$env:USERDOMAIN\$credential"
$secondDC="win11-DC2"
$dnsdomain=$env:USERDNSDOMAIN.tolower()



$remoteSession=New-PSSession -ComputerName $secondDC -Credential $domainCredential



Invoke-Command -Session $remoteSession -Scriptblock {



#
# Install AD Domain Services
#



$WindowsFeature="AD-Domain-Services"
if (Get-WindowsFeature $WindowsFeature -ComputerName $env:COMPUTERNAME | Where-Object { $_.installed -eq $false })
{
    write-host "Installing $WindowsFeature ..."
    Install-WindowsFeature $WindowsFeature -ComputerName $env:COMPUTERNAME -IncludeManagementTools
}
else
{
    write-host "$WindowsFeature already installed ..."
}



#
# Create Domain Controller
#
Install-ADDSDomainController ` -DomainName $args[0] `
-InstallDns:$true ` -Credential (Get-Credential $args[1]) `
-Force:$true

} -ArgumentList $dnsdomain, $domainCredential