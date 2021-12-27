#!/bin/sh

## Displays the Jamf Protect Tenant (instance name) that this client is enrolled to. ##
## Only valuable for organizations with multiple tenants. ##

#Jamf Protect Location
jamfProtectBinaryLocation="/usr/local/bin/protectctl"

if [ -f "$jamfProtectBinaryLocation" ]; then
    jamfProtectTenant=$("$jamfProtectBinaryLocation" info | awk -F 'Tenant: ' '{print $2}' | xargs)
else
	jamfProtectTenant="Protect binary does not exist"
fi

echo "<result>$jamfProtectTenant</result>"
