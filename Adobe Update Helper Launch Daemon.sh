#!/bin/bash

# Reports on the existence of the 
# Adobe Update Helper Launch Daemon
#
# Updated: 2.23.2022 @ Robjschroeder
#

if [ -e /Library/LaunchAgents/com.adobe.ARMDCHelper* ]; then
  echo "<result>True</result>"
else
  echo "<result>False</result>"
fi

exit 0
