#!/bin/bash

# Report the current version of Apple Remote Desktop

ARD_VERS=$(/usr/bin/defaults read /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/version.plist CFBundleVersion)

if [[ -f /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/version.plist ]]; then
    if [[ -n "${ARD_VERS}" ]]; then
        result="${ARD_VERS}"
        echo "<result>${result}</result>"
    else
        echo "<result>ARD Agent version not found</result>"
    fi
else
    echo "<result>ARD Agent Not Installed</result>"
fi
exit 0