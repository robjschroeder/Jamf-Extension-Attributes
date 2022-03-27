#!/bin/bash

# Reports the Topic ID (serial of the APNS cert) being used on the MDM profile
#
# Updated: 3.26.2022 @ Robjschroeder
#

topicID=`/usr/sbin/system_profiler SPConfigurationProfileDataType | awk '/Topic/{ print $NF }' | sed 's/[";]//g'`

if [ $topicID == "" ]; then
	echo "<result>No Push Cert</result>"
else
	echo "<result>$topicID</result>"
fi

exit 0
