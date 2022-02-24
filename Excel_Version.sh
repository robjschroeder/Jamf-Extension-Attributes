#!/bin/bash

# Reports the current version of 
# Microsoft Excel
#
# Updated: 2.23.2022 @ Robjschroeder
#
if [ -d /Applications/Microsoft\ Excel.app ]; then
    AppVersion=$(/usr/bin/defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString)
    echo "<result>${AppVersion}</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0
