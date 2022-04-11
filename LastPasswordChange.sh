#!/bin/bash

# Extension attribute to grab the last password
# change for the last logged on user
#
# Changed script to use dscl . -readpl (suggestion from Pico -- MadAdmins)

# Created 4.11.2022 @robjschroeder

# Grab the last logged in User
lastLoggedInUser=$( defaults read /Library/Preferences/com.apple.loginwindow lastUserName )
# Get the password change date of that User 
# lastPWChange="$(date -r "$(dscl . -readpl "/Users/$lastLoggedInUser" accountPolicyData passwordLastSetTime | awk -F ' |[.]' '{ print $2; exit }')")"
lastPWChange=$( dscl . -readpl /Users/$lastLoggedInUser accountPolicyData passwordLastSetTime | awk '{print $2}' | sed -n "s/\([0-9]*\).*/\1/p" )
#Format the time so we can use it as a Date/Time type in Jamf Pro EA
formattedTime=$(date -jf %s $lastPWChange "+%F %T")


echo "<result>$formattedTime</result>"

exit 0
