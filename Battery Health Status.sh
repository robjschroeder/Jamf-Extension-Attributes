#!/bin/bash

# Reports the Battery Health Status
# of Mac battery. 
#
# Created: 2.23.2022 @ Robjschroeder
#
# Updated 3.30.2022 @ Robert Schroeder
# Now using system_profiler to get the battery condition.
# Possible results are: 
#
# Normal
# Replace Soon
# Replace Now
# Service Battery
# Not A MacBook
#

# Determine model of computer
model=$(system_profiler SPHardwareDataType | grep "Model Name:" | cut -d ' ' -f 9)

# Get Battery Health status if computer is a MacBook
if [[ "${model}" =~ "Book" ]]; then
	# Determine battery health status
	result=$(system_profiler SPPowerDataType | grep "Condition" | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')
	echo "<result>${result}</result>"
else
	echo "<result>Not A MacBook</result>"
fi
