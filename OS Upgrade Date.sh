#!/bin/bash

# Returns the last OS update/upgrade date of macOS
#
# Created 08.30.2022 @robjschroeder

##################################################

# Evaluate the status in shell output
eval $(/usr/bin/stat -s /)

# Convert st_birthtime from epoch to a formatted time
formattedTime=$(/bin/date -jf %s "$st_birthtime" "+%F %T")

# Print the results
echo "<result>${formattedTime}</result>"

exit 0
