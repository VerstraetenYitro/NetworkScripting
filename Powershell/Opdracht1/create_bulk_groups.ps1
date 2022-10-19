#
# Create groups
#
$groups = Import-Csv C:\Users\Administrator.WIN11-DC1\Downloads\intranet.mijnschool.be\Groups.csv -Delimiter ";"

foreach ($item in $groups) {

    try {
    $path=$item.Path
    $name=$item.Name
    $displayName=$item.DisplayName
    $description=$item.Description
    $groupCat=$item.GroupCategory
    $groupScope=$item.GroupScope

    New-ADGroup `
    -Name $name `
    -Path $path `
    -DisplayName $displayName `
    -Description $description `
    -GroupCategory $groupCat `
    -GroupScope $groupScope

     Write-Host "AD-Object has been created..."
    }
    catch {
        Write-Host "AD-Object already exists..."
    }    
}

#
# Add users to groups
#
$usersAndGroups=Import-Csv C:\Users\Administrator.WIN11-DC1\Downloads\intranet.mijnschool.be\GroupMembers.csv -Delimiter ";"

foreach ($item in $usersAndGroups) {

    try {
    $groupname=$item.Identity
    $username=$item.Member
    Add-ADGroupMember -Identity $groupname -Members $username

    Write-Host "$username is placed in correct group."
    }
    catch {
        Write-Host "User is not placed in correct group."
    }    
}