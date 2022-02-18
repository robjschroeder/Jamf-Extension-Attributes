#!/bin/bash

fwstate=$(defaults read /Library/Preferences/com.apple.alf globalstate)
if [[  $fwstate != "0" ]]; then 
	echo "Firewall Global State is On"
	echo "<result>On</result>"
else
	echo "Firewall Global State is Off"
	echo "<result>Off</result>"
fi
