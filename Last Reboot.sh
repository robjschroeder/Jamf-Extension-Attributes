#!/bin/bash

# Get boottime in epoch time, convert to Jamf Pro formatted time and make an extension attribute
#
# Updated: 2.23.2022 @ Robjschroeder
#

bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)
formattedTime=$(date -jf %s $bootTime "+%F %T")
echo "<result>${formattedTime}</result>"

exit 0
