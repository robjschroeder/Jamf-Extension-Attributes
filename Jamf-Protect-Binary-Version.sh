#!/bin/sh

## Displays the version of the Jamf Protect binary. ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectVersion=$("$jamfProtectBinaryLocation" version | awk -F 'Version: ' '{print $2}')
else
	jamfProtectVersion="Protect binary not found"
fi

echo "<result>$jamfProtectVersion</result>"
