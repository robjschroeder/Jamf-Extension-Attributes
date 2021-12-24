#!/bin/bash

SMARTGROUPS_DIR=/Library/Application\ Support/JamfProtect/groups
if [ -d "$SMARTGROUPS_DIR" ]; then
	SMART_GROUPS=`/bin/ls "$SMARTGROUPS_DIR" | tr '\n' ','`
	echo "<result>${SMART_GROUPS%?}</result>"
else
	echo "<result></result>"
fi

exit 0