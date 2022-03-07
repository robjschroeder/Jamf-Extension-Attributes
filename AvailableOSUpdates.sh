#!/bin/bash

# Script will receive the available
# software updates from the softwareupdate
# binary and populate multiline results to 
# a Jamf Pro Extension Attribute
#
# Updated: 03.07.2022 @robjschroeder
#

# Get available software updates
RESULT=$(/usr/sbin/softwareupdate -l | grep "Label: " | sed 's/^.\{9\}//')

# Populate EA with multiline results
/usr/bin/printf "<result>$RESULT</result>"

exit 0
