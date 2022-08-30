#!/bin/bash

# Get boottime in epoch time, convert to Jamf Pro formatted time and make an extension attribute
#
# Updated: 2.23.2022 @robjschroeder
#
##################################################

# Get kernel boot time
bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)

# Convert time
formattedTime=$(date -jf %s $bootTime "+%F %T")

# Print the results
echo "<result>${formattedTime}</result>"

exit 0
