#!/bin/bash

# Reports the status of the Firewall
# Reads com.apple.sharing.firewall for older macOS
# Reads com.apple.alf for newer macOS
#
# Possible globalstate values:
# 0 = Off
# 1 = On for specific services
# 2 = On for essential services
#
# Updated: 2.23.2022 @ Robjschroeder
#

OS=$(/usr/bin/sw_vers -productVersion | /usr/bin/colrm 5)
if [[ "${OS}" < "10.5" ]]; then		
	result=$(/usr/bin/defaults read /Library/Preferences/com.apple.sharing.firewall state)
	if [ "${result}" == "YES" ]; then
		echo "<result>On</result>"
	elif [ "${result}" == "NO" ]; then
	echo "<result>Off</result>"
	fi
else
result=$(/usr/bin/defaults read /Library/Preferences/com.apple.alf globalstate)
	if [ "${result}" == "0" ]; then
		echo "<result>Off</result>"
	else
		echo "<result>On</result>"
	fi
fi

exit 0
