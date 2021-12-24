#!/bin/sh

APP_VERSION_KEY="CFBundleShortVersionString"

currentSlackVersion=$(/usr/bin/curl -s 'https://downloads.slack-edge.com/mac_releases/releases.json' | grep -o "[0-9]\.[0-9]\.[0-9]" | tail -1)

localSlackVersion=$(defaults read /Applications/Slack.app/Contents/Info.plist "CFBundleShortVersionString")


if [[ "${currentSlackVersion}" = "${localSlackVersion}" ]]; then
    result="Updated $localSlackVersion"
else 
    result="Not current"
fi


echo "<result>"$result"</result>"