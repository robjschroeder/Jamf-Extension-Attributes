#!/bin/sh

# Constants
PERPETUALLICENSE="/Library/Preferences/com.microsoft.office.licensingV2.plist"

# Detects the presence of a perpetual license
function DetectPerpetualLicense {
	if [ -f "$PERPETUALLICENSE" ]; then
		/bin/echo "Yes"
	else
		/bin/echo "No"
	fi
}

# Determines what type of perpetual license the machine has installed
function PerpetualLicenseType {
	if [ -f "$PERPETUALLICENSE" ]; then
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "A7vRjN2l/dCJHZOm8LKan11/zCYPCRpyChB6lOrgfi"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2019 Volume License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "Bozo+MzVxzFzbIo+hhzTl4JKv18WeUuUhLXtH0z36s"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2019 Preview Volume License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "A7vRjN2l/dCJHZOm8LKan1Jax2s2f21lEF8Pe11Y+V"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2016 Volume License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "DrL/l9tx4T9MsjKloHI5eX"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2016 Home and Business License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "C8l2E2OeU13/p1FPI6EJAn"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2016 Home and Student License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "Bozo+MzVxzFzbIo+hhzTl4m"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2019 Home and Business License"
				return
		fi
		/bin/cat "$PERPETUALLICENSE" | /usr/bin/grep -q "Bozo+MzVxzFzbIo+hhzTl4j"
		if [ "$?" == "0" ]; then
				/bin/echo "Office 2019 Home and Student License"
				return
		fi
		/bin/echo "Office Perpetual License"
	fi
}

# Creates a list of local usernames with UIDs above 500 (not hidden)
function DetectO365License {
	userList=$( /usr/bin/dscl /Local/Default -list /Users uid | /usr/bin/awk '$2 >= 501 { print $1 }' )
	
	while IFS= read aUser
	do
		# get the user's home folder path
		homePath=$( eval /bin/echo ~$aUser )
	
		# list of potential Office 365 activation files
		O365SUBMAIN="$homePath/Library/Group Containers/UBF8T346G9.Office/com.microsoft.Office365.plist"
		O365SUBBAK1="$homePath/Library/Group Containers/UBF8T346G9.Office/com.microsoft.e0E2OUQxNUY1LTAxOUQtNDQwNS04QkJELTAxQTI5M0JBOTk4O.plist"
		O365SUBBAK2="$homePath/Library/Group Containers/UBF8T346G9.Office/e0E2OUQxNUY1LTAxOUQtNDQwNS04QkJELTAxQTI5M0JBOTk4O" # hidden file
	
		# checks to see if an O365 subscription license file is present for each user
		if [[ -f "$O365SUBMAIN" || -f "$O365SUBBAK1" || -f "$O365SUBBAK2" ]]; then
			activations=$((activations+1))
		fi
	done <<< "$userList"
	
	# Returns the number of activations to O365ACTIVATIONS
	/bin/echo $activations
}

## Main

PERPETUALPRESENT=$(DetectPerpetualLicense)
O365ACTIVATIONS=$(DetectO365License)

if [ "$PERPETUALPRESENT" == "Yes" ] && [ "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>Volume and Office 365 licenses detected. Only the volume license will be used.</result>"

elif [ "$PERPETUALPRESENT" == "Yes" ]; then
	LICTYPE=$(PerpetualLicenseType)
	/bin/echo "<result>$LICTYPE</result>"
	
elif [ "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>Office 365 activations: $O365ACTIVATIONS</result>"
	
elif [ "$PERPETUALPRESENT" == "No" ] && [ ! "$O365ACTIVATIONS" ]; then
	/bin/echo "<result>No license</result>"
fi

exit 0