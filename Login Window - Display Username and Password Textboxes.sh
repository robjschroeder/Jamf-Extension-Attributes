#!/bin/sh
desiredValue="EditFromTemplate_Desired_Value_-_Example:_true"

appDomain="com.apple.loginwindow"
keyName="SHOWFULLNAME"
result=""
tmpResult="`dscl . mcxread /Computers/localhost \"$appDomain\" \"$keyName\" |grep Value:| awk {'print $2'}`"
if [ "$tmpResult" == "1" ]; then
result="true"
else
if [ "$tmpResult" == "0" ]; then
	result="false"
else
	if [ "$tmpResult" == "" ]; then
		result="Domain or Key Not Found"
	else
		result="$tmpResult"
	fi
fi
fi
if [ "$result" == "$desiredValue" ]; then
echo "<result>Pass ($result) </result>"
else
echo "<result>Fail ($result) </result>"
fi