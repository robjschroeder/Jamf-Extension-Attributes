#!/bin/sh

# Functions
function GetDeviceID {
	# creates a list of local usernames with UIDs above 500 (not hidden)
	userList=$( /usr/bin/dscl /Local/Default -list /Users uid | /usr/bin/awk '$2 >= 501 { print $1 }' )
	
	while IFS= read aUser
	do
		# get the user's home folder path
		HOMEPATH=$( eval /bin/echo ~$aUser )

		# grab the device id from the Office365ServiceV2 log
		local RESULT=$(/usr/bin/grep -m1 'iaaaa' $HOMEPATH/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches/Microsoft/uls/com.microsoft.Office365ServiceV2/logs/*.log | cut -f8)
	
		# checks to see if we got a hit
		if [ "$RESULT" != "" ]; then
			ID="$RESULT"
		fi
	done <<< "$userList"
	
	/bin/echo "$ID"
}

## Main
DEVICEID=$(GetDeviceID)
if [ "$DEVICEID" != "" ]; then
	/bin/echo "<result>$DEVICEID</result>"
else
	/bin/echo "<result>Not detected</result>"
fi

exit 0