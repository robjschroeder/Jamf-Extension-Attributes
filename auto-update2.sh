#!/usr/bin/env bash
##########################################################################################
# A script to collect the version of Microsoft AutoUpdate that is currently installed.   #
# If Microsoft AutoUpdate is not installed, "Not Installed" will be returned to the JSS. #
##########################################################################################

RESULT="Not Installed"
if [ -f "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/Info.plist" ] ; then
RESULT=$( /usr/bin/defaults read "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/Info.plist" CFBundleVersion )
fi

/bin/echo "<result>$RESULT</result>"