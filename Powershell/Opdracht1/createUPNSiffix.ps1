#Creating alternative UPN suffix



Get-ADForest | Set-ADForest -UPNSuffixes @{add = "mijnschool.be" }
Write-Host "UPN Suffix set to 'mijnschool.be'..."



#Specify UPN Domain
$Domain = 'mijnschool.be'

#Get list of samaccountnames in our targeted OU
$UserList = Get-ADUser -Filter * | `
    select -ExpandProperty SamAccountName

#Change UPN Suffix from sub domain to primary domain
foreach ($User in $UserList) {
    Get-ADUser $User | Set-ADUser -UserPrincipalName "$User@$Domain"
}

Get-ADUser -Filter *