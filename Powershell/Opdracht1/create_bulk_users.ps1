$ADUSERS=Import-csv C:\Users\Administrator.WIN11-DC1\Downloads\intranet.mijnschool.be\UserAccounts.csv -Delimiter ';'

foreach($account in $ADUSERS){
# Create users
New-ADUser -Name $account.Name `
-DisplayName $account.DisplayName `
-Surname $account.Surname `
-Path $account.Path `
-SamAccountName $account.SamAccountName `
-GivenName $account.GivenName `
-HomeDirectory $account.HomeDirectory`
-PasswordNeverExpires `
-ScriptPath $account.ScriptPath`
-Enabled $true `
-AccountPassword $account.AccountPassword `
-ChangePasswordAtLogon $false


#Make home dirs

}