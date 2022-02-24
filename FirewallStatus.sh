#!/bin/bash

# Reports the status of the Firewall
# Possible globalstate values:
# 0 = Off
# 1 = On for specific services
# 2 = On for essential services
#
# Updated: 2.23.2022 @ Robjschroeder
#

fwstate=$(defaults read /Library/Preferences/com.apple.alf globalstate)
if [[  $fwstate != "0" ]]; then 
	echo "Firewall Global State is On"
	echo "<result>On</result>"
else
	echo "Firewall Global State is Off"
	echo "<result>Off</result>"
fi

exit 0
