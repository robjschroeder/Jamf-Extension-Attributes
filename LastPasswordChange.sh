#!/bin/bash

# Extension attribute to grab the last password
# change for the last logged on user

# Created 3.31.2022 @robjschroeder

# Grab the last logged in User
lastLoggedInUser=$( defaults read /Library/Preferences/com.apple.loginwindow lastUserName )
# Get the password change date of that User
lastPWChange=$( date -r $(dscl . -read /Users/$lastLoggedInUser accountPolicyData |
	tail -n +2 |
	plutil -extract passwordLastSetTime xml1 -o - -- - |
	sed -n "s/<real>\([0-9]*\).*/\1/p"))

echo "<result>$lastPWChange</result>"

exit 0
