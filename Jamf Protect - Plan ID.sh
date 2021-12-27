#!/bin/sh

## Displays the Plan ID specified by Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectPlanID=$("$jamfProtectBinaryLocation" info | awk -F 'Plan ID: ' '{print $2}' | xargs)
else
	jamfProtectPlanID="Protect binary not found"
fi

echo "<result>$jamfProtectPlanID</result>"
