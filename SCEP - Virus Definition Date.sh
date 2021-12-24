#!/bin/sh
#Created by Robert Schroeder 10.2.2018
#Check to see if SCEP is installed
if [ -f "/Library/Application Support/Microsoft/scep/modules/data/updfiles/upd.ver" ]; then
	result=`/bin/date -r "/Library/Application Support/Microsoft/scep/modules/data/updfiles/upd.ver" +"%Y-%m-%d %H:%M:%S"`
	echo "<result>$result</result>"
else
	echo "<result>Not installed</result>"
fi