#!/bin/bash

# Return the value set in Text4 field 
# of the Remote Desktop plist
#
# Updated: 11.21.2022 @ Robjschroeder
#

# Reports the value stored in Apple Remote Desktop Field 4

path="/Library/Preferences"
domainPlist="com.apple.RemoteDesktop.plist"
key="Text4"
defaultsRead="/usr/bin/defaults read $path/$domainPlist $key"

if ($defaultsRead) > /dev/null 2>&1; then
	RESULT=$($defaultsRead)
else
	RESULT="Field does not exist"
fi

echo "<result>$RESULT</result>"
