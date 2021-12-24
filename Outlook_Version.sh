#!/bin/sh
if [ -d /Applications/Microsoft\ Outlook.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Microsoft\ Outlook.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0
