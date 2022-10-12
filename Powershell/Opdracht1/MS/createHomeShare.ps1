New-Item "C:\SharedFolder" -Type Directory

New-SmbShare -Name "FolderShare" -Path "C:\SharedFolder" -FullAccess "MSNOOB\Administrators", "MSNOOB\MS-RDS1$"