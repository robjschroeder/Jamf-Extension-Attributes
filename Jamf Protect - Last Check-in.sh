#!/bin/sh

## Displays the date and time of the last agent check-in for Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectLastCheckin=$("$jamfProtectBinaryLocation" info | sed -n '4 p' |  awk -F 'Last Check-in:' '{print $2}' | xargs)
else
	jamfProtectLastCheckin="Does not exist"
fi

echo "jamfProtectLastCheckin"
echo "<result>$jamfProtectLastCheckin</result>"
