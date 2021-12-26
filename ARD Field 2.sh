#!/bin/sh

# Reports the value stored in Apple Remote Desktop Field 2

if [ -f "/Library/Preferences/com.apple.RemoteDesktop.plist" ]; then
echo "<result>`/usr/bin/defaults read /Library/Preferences/com.apple.RemoteDesktop Text2`</result>"
fi
