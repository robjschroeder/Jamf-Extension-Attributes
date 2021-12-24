#!/bin/sh
if [ -d /Applications/Microsoft\ PowerPoint.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Microsoft\ PowerPoint.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0
