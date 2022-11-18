#!/bin/bash
sudo apt install bc

find / -name '*.pem' -print0 | while IFS= read -d '' -r file
do 
command=`openssl x509 -in "$file" -text -noout | grep "Not After" | cut -c 25-`
days=`echo "(" $(date -d "$command" +%s) - $(date -d "now" +%s) ")" / 86400 | bc`
INT2=14
if [ $days -le $INT2 ]; then
  echo "$file"
fi
done