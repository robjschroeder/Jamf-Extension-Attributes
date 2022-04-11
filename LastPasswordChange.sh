#!/bin/bash

# Extension attribute to grab the last password
# change for the last logged on user
#
# Changed script to use dscl . -readpl (suggestion from Pico -- MadAdmins)

# Created 4.11.2022 @robjschroeder

# Grab the last logged in User
lastLoggedInUser=$( defaults read /Library/Preferences/com.apple.loginwindow lastUserName )
# Get the password change date of that User 
lastPWChange="$(date -r "$(dscl . -readpl "/Users/$lastLoggedInUser" accountPolicyData passwordLastSetTime | awk -F ' |[.]' '{ print $2; exit }')")"

echo "<result>$lastPWChange</result>"

exit 0
