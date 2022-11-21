#!/bin/bash

# Return the value set in CatalogURL field 
# of the Software Update plist
#
# Updated: 11.21.2022 @ Robjschroeder
#

# Reports the value stored in Software Update CatalogURL

path="/Library/Preferences"
domainPlist="com.apple.SoftwareUpdate.plist"
key="CatalogURL"
defaultsRead="/usr/bin/defaults read $path/$domainPlist $key"

if ($defaultsRead) > /dev/null 2>&1; then
	RESULT=$($defaultsRead)
else
	RESULT="Field does not exist"
fi

echo "<result>$RESULT</result>"
