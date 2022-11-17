$credential="administrator"
$domainCredential="$env:USERDOMAIN\$credential"
$secondDC="WIN11-DC2"
$dnsdomain=$env:USERDNSDOMAIN.tolower()



$remoteSession=New-PSSession -ComputerName $secondDC -Credential $domainCredential


Invoke-Command -Session $remoteSession -Scriptblock {
    $WindowsFeature="DHCP"
    if (Get-WindowsFeature $WindowsFeature -ComputerName $env:COMPUTERNAME | Where-Object { $_.installed -eq $false })
    {
        write-host "Installing $WindowsFeature ..."
        Install-WindowsFeature $WindowsFeature -ComputerName $env:COMPUTERNAME -IncludeManagementTools
    }
    else
    {
        write-host "$WindowsFeature already installed ..."
    }
    # authorize dhcp server
    netsh DHCP add SecurityGroups

    Add-DhcpServerInDC -DnsName Win11-DC2.intranet.mijnschool.be
}

Add-DhcpServerv4Failover -ComputerName $env:COMPUTERNAME -Name "Loadbalance" -PartnerServer "WIN11-DC2" -ScopeId 192.168.1.0 -LoadBalancePercent 50

Invoke-Command -Session $remoteSession -Scriptblock {
   Set-DhcpServerV4OptionValue -DnsServer 192.168.1.3,192.168.1.2 -Router 192.168.1.1
}

Set-DhcpServerV4OptionValue -DnsServer 192.168.1.2,192.168.1.3