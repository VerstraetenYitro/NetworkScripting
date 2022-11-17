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
    
$acl = Get-Acl \\WIN11-MS\C$\homes
#First Parameter - To block Inheritance from the parent folder
#Second Parameter - $False = To Remove all existing Folder Permission , $True = To Retain
$acl.SetAccessRuleProtection($true,$false)
$acl | Set-Acl \\WIN11-MS\C$\homes

#Permission for Administrators
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl", "ContainerInherit, ObjectInherit","None", "Allow")
$acl.SetAccessRule($AccessRule)

#Permission for Authenticated Users
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated Users","ReadAndExecute", "None", "NoPropagateInherit", "Allow")
$acl.SetAccessRule($AccessRule)

#Apply NTFS permission to folder
$acl | Set-Acl \\WIN11-MS\C$\homes

} -ArgumentList $dnsdomain, $domainCredential