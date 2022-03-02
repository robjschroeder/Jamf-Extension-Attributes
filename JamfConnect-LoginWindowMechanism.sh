#!/bin/sh

# Script will report whether the computer is
# using the macOS login window or Jamf Connect
# login window

# Updated: 3.01.2022 @robjschroeder

loginwindow_check=$(security authorizationdb read system.login.console | grep 'loginwindow:login' 2>&1 > /dev/null; echo $?)

if [ $loginwindow_check == 0 ]; then
    echo "<result>OS LoginWindow</result>"
else
    echo "<result>JC LoginWindow</result>"
fi
