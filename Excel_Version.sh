<?xml version="1.0" encoding="UTF-8"?><extensionAttribute>
#!/bin/sh
if [ -d /Applications/Microsoft\ Excel.app ]; then
    AppVersion=`/usr/bin/defaults read /Applications/Microsoft\ Excel.app/Contents/Info.plist CFBundleShortVersionString`
    echo "<result>$AppVersion</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0