#!/bin/sh

## Displays the date and time of the last agent check-in for Jamf Protect ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectLastCheckin=$("$jamfProtectBinaryLocation" info | awk -F 'Last Check-in:' '{print $2}' | xargs)
else
	jamfProtectLastCheckin="Protect binary not found"
fi

echo "<result>$jamfProtectLastCheckin</result>"
