#!/bin/sh

# Reports the value stored in Apple Remote Desktop Field 4

if [ -f "/Library/Preferences/com.apple.RemoteDesktop.plist" ]; then
echo "<result>`/usr/bin/defaults read /Library/Preferences/com.apple.RemoteDesktop Text4`</result>"
fi