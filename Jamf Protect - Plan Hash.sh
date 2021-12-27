#!/bin/sh

## Displays the hash of the Plan specified by Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectPlanHash=$("$jamfProtectBinaryLocation" info | awk -F 'Plan Hash:' '{print $2}' | xargs)
else
	jamfProtectPlanHash="Protect binary not found"
fi

echo "<result>$jamfProtectPlanHash</result>"
