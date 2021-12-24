#!/bin/sh

desiredResult="auth.err				/var/log/secure.log"
result=`cat /private/etc/syslog.conf | grep "$desiredResult" | tail -1`

if [ "$result" == "$desiredResult" ]; then
echo "<result>Pass ($result)</result>"
else
if [ "$result" == "" ]; then
	echo "<result>Fail (Authentication Error Logging Not Enabled)</result>"
else
	echo "<result>Fail ($result)</result>"
fi
fi