#!/bin/bash

# Returns the orignial install date of macOS
#
# Created 08.30.2022 @robjschroeder

##################################################

# Get original macOS Install Date in epoch time
originDate=$(/usr/bin/stat -f "%B" /var/db/.AppleSetupDone)

# Convert the epoch time into a formatted time
formattedTime=$(date -jf %s $originDate "+%F %T")

# Print the results
echo "<result>${formattedTime}</result>"

exit 0
