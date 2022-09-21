$RDPStatus=Get-

Enable Remote Desktop: Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

Disable Remote Desktop: Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 1

Enable Remote Desktop From Firewall: Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Disable Remote Desktop From Firewall: Disable-NetFirewallRule -DisplayGroup "Remote Desktop"