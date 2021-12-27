#!/bin/sh

## Displays the Threat Prevention Version of Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectThreatPreventionVersion=$("$jamfProtectBinaryLocation" info | awk -F 'Threat Prevention Version:' '{print $2}' | xargs)
else
	jamfProtectThreatPreventionVersion="Protect binary not found"
fi

echo "<result>$jamfProtectThreatPreventionVersion</result>"
