#!/bin/sh

# Returns list of O365 logons
#
# Updated: 2.26.2022 @ Robjschroeder

# Functions
function DetectO365Logon {
	# creates a list of local usernames with UIDs above 500 (not hidden)
	userList=$( /usr/bin/dscl /Local/Default -list /Users uid | /usr/bin/awk '$2 >= 501 { print $1 }' )
	
	while IFS= read aUser
	do
		# get the user's home folder path
		HOMEPATH=$( eval /bin/echo ~$aUser )

		# execute some sql to get the active O365 logon, if any
		local RESULT=$(/usr/bin/sqlite3 "$HOMEPATH/Library/Group Containers/UBF8T346G9.Office/MicrosoftRegistrationDB.reg" "SELECT value from HKEY_CURRENT_USER_values WHERE name='UserDisplayName' LIMIT 1;")
	
		# checks to see if we got a hit
		if [ "$RESULT" != "" ]; then
			logons+="$RESULT;"
		fi
	done <<< "$userList"
	
	/bin/echo "$logons"
}

## Main
O365LOGONS=$(DetectO365Logon)
if [ "$O365LOGONS" != "" ]; then
	/bin/echo "<result>$O365LOGONS</result>"
else
	/bin/echo "<result>None detected</result>"
fi

exit 0
