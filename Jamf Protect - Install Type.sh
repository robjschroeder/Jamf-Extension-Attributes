#!/bin/sh

## Displays if Jamf Protect is installed as binary installation or system extension instalation ##

#Jamf Protect Install Type
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
	jamfProtectInstallType=$("$jamfProtectBinaryLocation" info | awk -F 'Install Type: ' '{print $2}' | xargs)
else
	jamfProtectInstallType="Protect binary not found"
fi

echo "<result>$jamfProtectInstallType</result>"
