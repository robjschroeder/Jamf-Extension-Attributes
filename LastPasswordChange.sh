#!/bin/bash

# Extension attribute to grab the last password
# change for the last logged on user
#
# Changed script to use dscl . -readpl

# Created 4.11.2022 @robjschroeder

# Grab the last logged in User
lastLoggedInUser=$( defaults read /Library/Preferences/com.apple.loginwindow lastUserName )
# Get the password change date of that User
lastPWChange=$( dscl . -readpl /Users/$lastLoggedInUser accountPolicyData passwordLastSetTime | awk '{print $2}' | sed -n "s/\([0-9]*\).*/\1/p" )
# Change Time format to readable time
formattedTime=$(date -jf %s $lastPWChange "+%F %T")

echo "<result>$formattedTime</result>"

exit 0
