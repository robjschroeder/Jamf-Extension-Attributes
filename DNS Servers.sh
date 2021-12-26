#!/bin/sh

# Reports current DNS Server on macOS

OS=`/usr/bin/sw_vers -productVersion | /usr/bin/colrm 5`
if [[ "$OS" < "10.5" ]]; then
if [ -f /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Support/networksetup ];then		
	NetworkInterface=`/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Support/networksetup -listnetworkserviceorder 2>&1 | grep $(/usr/sbin/netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $6 }') | sed -e "s/.*Port: //g" -e "s/,.*//g"`
	echo "<result>`/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Support/networksetup -getdnsservers "$NetworkInterface" 2>&1`</result>"
else
	echo "<result>The networksetup binary is not present on this machine.</result>"
fi
else
NetworkInterface=`/usr/sbin/networksetup -listnetworkserviceorder 2>&1 | grep $(/usr/sbin/netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $6 }') | sed -e "s/.*Port: //g" -e "s/,.*//g"`
echo "<result>`/usr/sbin/networksetup -getdnsservers "$NetworkInterface" 2>&1`</result>"
fi