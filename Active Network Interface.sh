#!/bin/bash
ref=$(/usr/bin/sw_vers -productVersion | awk '{print substr($1,4,2)}')
case $ref in
[0-4] ) ntwkset="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Support/networksetup -listnetworkserviceorder"
        ;;
     *) ntwkset="networksetup -listnetworkserviceorder"
        ;;
esac

ifconfigoutput='
BEGIN            { print_it = 0 }
/status: active/ { print_it = 1 }
/^($|[^\t])/     { if(print_it) print buffer; buffer = $0; print_it = 0 }
/^\t/            { buffer = buffer "\n" $0 }
END              { if(print_it) print buffer }
'

ntwkint=($(ifconfig -u | awk "$ifconfigoutput" | awk '/flags/{print substr($1,1,3)}'))
/bin/echo -n $"<result>"
for x in "${ntwkint[@]}"
do
	echo `$ntwkset | grep "$x" | sed -e 's/[)(]//g;s/,//g;s/.*Port: //g;s/Device:\ //g'`
done
echo "</result>"