#!/bin/sh

if [ -d "/Library/Application Support/VMware Fusion/" ]; then
 result=`cat /Library/Application\ Support/VMware\ Fusion/license* | grep Serial | awk '{print $3}' | sed 's/"//g'`
fi

echo "<result>$result</result>"