#
#set_hostname
#
$current_hostname=hostname
$new_hostname="win11-DC1"

Rename-Computer -ComputerName $current_hostname -NewName $new_hostname -Restart -Confirm:$false