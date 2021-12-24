#!/usr/bin/env bash
##############################################################################
# A script to collect the version of Silverlight currently installed.        #
# If Silverlight is not installed "Not Installed" will return back           #
##############################################################################
RESULT="Not Installed"

if [ -f "/Library/Internet Plug-Ins/Silverlight.plugin/Contents/Info.plist" ] ; then
RESULT=$( /usr/bin/defaults read "/Library/Internet Plug-Ins/Silverlight.plugin/Contents/Info.plist" CFBundleVersion )
fi

/bin/echo "<result>$RESULT</result>"