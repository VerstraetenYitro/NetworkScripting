# author: activedirectorypro.com
# This script is used for creating bulk organizational units.

# Import active directory module for running AD cmdlets
Import-Module activedirectory

#Store the data from the CSV in the $ADOU variable. 
$ADOU = Import-csv C:\Users\Administrator.WIN11-DC1\Downloads\intranet.mijnschool.be\OUs.csv -Delimiter ';'

#Loop through each row containing user details in the CSV file
foreach ($ou in $ADou)
{
#Read data from each field in each row and assign the data to a variable as below
$path = $ou.Path
$name = $ou.Name
$Desc=$ou.Description
$DisplayN=$ou.'Display Name'


#Account will be created in the OU provided by the $OU variable read from the CSV file
New-ADOrganizationalUnit `
-Name $name `
-path $path `
-Description $Desc `
-DisplayName $DisplayN

}