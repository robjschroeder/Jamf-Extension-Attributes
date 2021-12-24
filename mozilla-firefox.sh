#!/usr/bin/env bash

##############################################################################
#Script is designed to return the 'version number' of Mozilla Firefox.       #
#Locates the the installed firefox application verifies 'release'            #
#before returning 'version number' or 'not installed'                        #
##############################################################################
RESULT="Not Installed"

for i in /Applications/Firefox*.app; do
  /usr/bin/grep mozilla-release "$i"/Contents/Resources/application.ini
  if [[ $? -eq 0 ]]; then
  	RESULT=$(/usr/bin/defaults read "$i"/Contents/Info.plist CFBundleShortVersionString)
  fi
done
/bin/echo "<result>$RESULT</result>"