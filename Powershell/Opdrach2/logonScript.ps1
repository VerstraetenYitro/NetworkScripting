Import-Module ActiveDirectory

$users = Get-ADUser -Filter * 

foreach ($user in $users) {

 $ScriptPath = "\\WIN11-DC1\NETLOGON\login"

 Set-ADUser $user -ScriptPath $ScriptPath
 }