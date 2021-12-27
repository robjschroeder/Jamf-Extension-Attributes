#!/bin/sh

## Displays the date and time of the last Insights check-in for Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectInfoInsightsSync=$("$jamfProtectBinaryLocation" info | awk -F 'Last Insights:' '{print $2}' | xargs)
else
	jamfProtectInfoInsightsSync="Protect binary not found"
fi

echo "<result>$jamfProtectInfoInsightsSync</result>"
