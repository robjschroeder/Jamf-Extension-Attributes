#!/bin/sh

## Displays the status of Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectStatus=$("$jamfProtectBinaryLocation" info | awk '/Status:/{print $2}')
else
	jamfProtectStatus="Protect binary not found"
fi

echo "<result>$jamfProtectStatus</result>"
