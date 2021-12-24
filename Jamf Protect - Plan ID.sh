#!/bin/sh

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectPlanID=$("$jamfProtectBinaryLocation" info | sed -n '1 p' |  awk -F 'Plan ID: ' '{print $2}' | xargs)
else
	jamfProtectPlanID="Does not exist"
fi

echo "jamfProtectPlanID"
echo "<result>$jamfProtectPlanID</result>"