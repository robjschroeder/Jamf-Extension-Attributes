#!/bin/sh
if [ -d /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app ]; then
    HowToCheck=`python -c "from Foundation import CFPreferencesCopyAppValue; print CFPreferencesCopyAppValue('HowToCheck', 'com.microsoft.autoupdate2')"`
    echo "<result>$HowToCheck</result>"
else
    echo "<result>Not installed</result>"
fi

exit 0
