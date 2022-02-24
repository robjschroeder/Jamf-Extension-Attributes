#!/bin/bash

# Report the last logged in user
#
# Updated: 2.23.2022 @ Robjschroeder
#

lastUser=$(/usr/bin/last -1 -t console | awk '{print $1}')

if [ ${lastUser} == "wtmp" ]; then
echo "<result>No logins</result>"
else
echo "<result>${lastUser}</result>"
fi

exit 0
