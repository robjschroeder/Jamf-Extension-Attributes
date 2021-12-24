#!/bin/sh
lastUser=`/usr/bin/last -1 -t console | awk '{print $1}'`

if [ $lastUser == "wtmp" ]; then
echo "<result>No logins</result>"
else
echo "<result>$lastUser</result>"
fi