#!/bin/sh
if [ -e /Applications/Install\ macOS\ Catalina.app/Contents/Resources/startosinstall* ]
then 
  echo "<result>True</result>"
else
  echo "<result>False</result>"
fi