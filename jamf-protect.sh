#!/bin/bash
##############################################################################
# A script to collect the version of Jamf Protect installed.                 #
# If Jamf Protect is not installed "Not Installed" will return back   	     #
##############################################################################

NOT_INSTALLED="Not Installed"
RESULT=""

if [ -a /Library/Application\ Support/JamfProtect/JamfProtect.app/Contents/Info.plist ]
  then
    RESULT=$( /usr/bin/defaults read /Library/Application\ Support/JamfProtect/JamfProtect.app/Contents/Info.plist CFBundleShortVersionString )
else
    RESULT="$NOT_INSTALLED"
fi
/bin/echo "<result>$RESULT</result>"