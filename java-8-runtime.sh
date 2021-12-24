#!/usr/bin/env bash
#######################################################################################
# Collects information to determine which version of the Java plugin is installed and # 
# then returning that version back if major version (1.X) match what we're searching  # 
# for with SEARCH_FOR_VERSION. Builds the result as 1.X.Y, ignoring the build number, #
# where X is major version and Y is the minor version.								  #	
#######################################################################################
NOT_INSTALLED="Not Installed"
SEARCH_FOR_VERSION="8"
RESULT=""

if [ -f "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Enabled.plist" ] ; then
	RESULT=$( /usr/bin/defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Enabled.plist" CFBundleVersion )
	REPORTED_MAJOR_VERSION=`/bin/echo "$RESULT" | /usr/bin/awk -F'.' '{print $2}'`
	REPORTED_MINOR_VERSION=`/bin/echo "$RESULT" | /usr/bin/awk -F'.' '{print $3}'`
	if [ "$REPORTED_MAJOR_VERSION" != "$SEARCH_FOR_VERSION" ] ; then
		RESULT="$NOT_INSTALLED"
	else
		RESULT=1."$REPORTED_MAJOR_VERSION".$REPORTED_MINOR_VERSION
	fi
else
	RESULT="$NOT_INSTALLED"
fi

/bin/echo "<result>$RESULT</result>"