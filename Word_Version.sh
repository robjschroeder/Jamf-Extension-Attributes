#!/bin/sh
if [ -d /Applications/Microsoft\ Word.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Microsoft\ Word.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0