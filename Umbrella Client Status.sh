#!/bin/bash


if [ -f "/Library/LaunchDaemons/com.opendns.osx.RoamingClientConfigUpdater.plist" ]; then


ps auwwx | egrep "dnscrypt|RoamingClientMenubar|dns-updater" | grep -vq egrep;
    if [[ 0 == $? ]]; then
        echo "<result>Enabled</result>"
    else
echo "<result>Disabled</result>"
 fi



else
echo "<result>Not Installed</result>"
fi