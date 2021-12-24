#!/bin/sh

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectInfoInsightsSync=$("$jamfProtectBinaryLocation" info | sed -n '5 p' |  awk -F 'Last Insights:' '{print $2}' | xargs)
else
	jamfProtectInfoInsightsSync="Does not exist"
fi

echo "jamfProtectInfoInsightsSync"
echo "<result>$jamfProtectInfoInsightsSync</result>"