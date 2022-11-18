#!/bin/bash
#plan every sunday at 17:00
(crontab -l; echo "0 17 * * 0 bash /home/user/NetworkScripting/Bash/backup.sh")|awk '!x[$0]++'|crontab -