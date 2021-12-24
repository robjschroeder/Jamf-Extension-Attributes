#!/bin/sh
if [ -d /Applications/Skype\ for\ Business.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Skype\ for\ Business.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0
