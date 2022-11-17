$path="\\WIN11-MS\C$\Public"

New-Item -Path $path -ItemType directory
New-SmbShare -CimSession WIN01-MS -Name Public -Path C:\Public -FullAccess Everyone

$acl = Get-Acl $path
#First Parameter - To block Inheritance from the parent folder
#Second Parameter - $False = To Remove all existing Folder Permission , $True = To Retain
$acl.SetAccessRuleProtection($true,$false)
$acl | Set-Acl $path

#Permission for Administrators
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl", "ContainerInherit, ObjectInherit","None", "Allow")
$acl.SetAccessRule($AccessRule)

#Permission for Authenticated Users
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated Users","Modify", "ContainerInherit, ObjectInherit","None", "Allow")
$acl.SetAccessRule($AccessRule)



#Apply NTFS permission to folder
$acl | Set-Acl $path