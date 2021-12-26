#!/bin/sh

# Reports the value stored in Apple Remote Desktop Field 1

if [ -f "/Library/Preferences/com.apple.RemoteDesktop.plist" ]; then
echo "<result>`/usr/bin/defaults read /Library/Preferences/com.apple.RemoteDesktop Text1`</result>"
fi