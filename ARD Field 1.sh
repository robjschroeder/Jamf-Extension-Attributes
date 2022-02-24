#!/bin/bash

# Return the value set in Text1 field 
# of the Remote Desktop plist
#
# Updated: 2.23.2022 @ Robjschroeder
#
# Reports the value stored in Apple Remote Desktop Field 1

if [ -f "/Library/Preferences/com.apple.RemoteDesktop.plist" ]; then
echo "<result>`/usr/bin/defaults read /Library/Preferences/com.apple.RemoteDesktop Text1`</result>"
fi

exit 0
