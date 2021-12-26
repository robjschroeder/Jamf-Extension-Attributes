#!/bin/sh

# Reports on the existence of the Adobe Update Helper Launch Daemon

if [ -e /Library/LaunchAgents/com.adobe.ARMDCHelper* ]; then
  echo "<result>True</result>"
else
  echo "<result>False</result>"
fi