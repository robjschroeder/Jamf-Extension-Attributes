#!/bin/sh
if [ -d /Applications/Microsoft\ OneNote.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Microsoft\ OneNote.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0