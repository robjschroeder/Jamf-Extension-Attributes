#!/bin/sh
if [ -d /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app ]; then
    ChannelName=`python -c "from Foundation import CFPreferencesCopyAppValue; print CFPreferencesCopyAppValue('ChannelName', 'com.microsoft.autoupdate2')"`
    if [ "$ChannelName" == "External"]; then
    	echo "<result>Insider Slow</result>"
    elif [ "$ChannelName" == "Insider_Fast"]; then
    	echo "<result>Insider Fast</result>"
    elif [ "$ChannelName" == "Internal"]; then
    	echo "<result>Microsoft</result>"
    elif [ "$ChannelName" == "Dogfood"]; then
    	echo "<result>Dogfood</result>"
    elif [ "$ChannelName" == "Custom"]; then
    	ManifestServer=`python -c "from Foundation import CFPreferencesCopyAppValue; print CFPreferencesCopyAppValue('ManifestServer', 'com.microsoft.autoupdate2')"`
    	echo "<result>Custom - $ManifestServer</result>"
    else
    	echo "<result>Production</result>"
    fi
else
    echo "<result>Not installed</result>"
fi

exit 0