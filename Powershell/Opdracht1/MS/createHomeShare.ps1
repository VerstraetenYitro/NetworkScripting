#
# Creating a home share
#
$credential="administrator"
$domainCredential="$env:USERDOMAIN\$credential"
$computername="win11-MS"
$dnsdomain=$env:USERDNSDOMAIN.tolower()



$remoteSession=New-PSSession -ComputerName $computername -Credential $domainCredential



Invoke-Command -Session $remoteSession -Scriptblock {

New-Item "C:\homes" -Type Directory

New-SmbShare -Name "homes" -Path "C:\homes" -ChangeAccess "Users" -FullAccess "Administrators"


} -ArgumentList $dnsdomain, $domainCredential