#
# Create groups
#
$groups = Import-Csv C:\Users\Administrator.WIN11-DC1\Downloads\intranet.mijnschool.be\Groups.csv -Delimiter ";"

foreach ($item in $groups) {

    try {
    Path;Name;DisplayName;Description;GroupCategory;GroupScope
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