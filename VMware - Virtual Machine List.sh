#!/bin/sh

OS=`/usr/bin/sw_vers -productVersion | /usr/bin/colrm 5`

if [[ "$OS" < "10.6" ]]; then
myVMList=`find /Users -name "*.vmx"`
else
myVMList=`mdfind -name ".vmx" | grep -Ev "vmx.lck" | grep -Ev "vmxf"`
fi

IFS=$'\n'
myCount=1
echo "<result>"
for myFile in $myVMList
do
myNetwork=`cat "$myFile"| grep "ethernet.*.connectionType"| awk '{print \$3}'| sed 's/\"//g'`
myDisplayName=`cat "$myFile"| grep "displayName"| sed 's/displayName = //g'| sed 's/\"//g'`
myMemSize=`cat "$myFile"| grep "memsize"| awk '{print \$3}'| sed 's/\"//g'`
myUUID=`cat "$myFile"| grep "uuid.bios"| sed 's/uuid.bios = //g'| sed 's/\"//g'`
myMAC=`cat "$myFile"| grep "ethernet.*.generatedAddress"| grep -v "Offset"| awk '{print \$3}'| sed 's/\"//g'`

echo "=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "VMWare VM #$myCount"
echo "File Name: $myFile"
echo "Display Name: $myDisplayName"
echo "Network Type: $myNetwork"
echo "MAC Address: $myMAC"
echo "Memory: $myMemSize MB"
echo "UUID: $myUUID"
	
let myCount=myCount+1
done
echo "</result>"

unset IFS