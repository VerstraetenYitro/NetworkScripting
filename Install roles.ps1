#Variabelen
$computerName = win11-DC1

#installeer ADDS, 



Install-WindowsFeature -Name AD-Domain-Services -computerName $computerName -IncludeManagementTools -Restart