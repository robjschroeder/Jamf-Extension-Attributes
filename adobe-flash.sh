#!/usr/bin/env bash
##############################################################################
# A script to collect the version of Adobe Flash Player currently installed. #
# If flash is not installed "Not Installed" will return back                 #
##############################################################################

RESULT="Not Installed"

if [ -f "/Library/Internet Plug-Ins/Flash Player.plugin/Contents/version.plist" ] ; then
  RESULT=$( /usr/bin/defaults read "/Library/Internet Plug-Ins/Flash Player.plugin/Contents/version.plist" CFBundleVersion )
fi
/bin/echo "<result>$RESULT</result>"