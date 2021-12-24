#!/bin/sh

#EA to record office profile deployment ready
result="no"

if [ -f /Library/Management/receipts/deploy-office-profile ]; then
result=yes
fi

echo "<result>$result</result>"
