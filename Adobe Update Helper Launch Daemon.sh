#!/bin/sh
if [ -e /Library/LaunchAgents/com.adobe.ARMDCHelper* ]; then
  echo "<result>True</result>"
else
  echo "<result>False</result>"
fi