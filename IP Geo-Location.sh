#!/bin/sh
### Currently not working, page doesn't seem to exist anymore ###
### 2.26.22 ###

myIP=`curl -L -s --max-time 10 http://checkip.dyndns.org | egrep -o -m 1 '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}'`
myLocationInfo=`curl -L -s --max-time 10 http://freegeoip.appspot.com/xml/$myIP`
    
myCountryCode=`echo $myLocationInfo|egrep -o '<CountryCode>.*</CountryCode>'| sed -e 's/^.*<CountryCode/<CountryCode/' | cut -f2 -d'>'| cut -f1 -d'<'`
myCity=`echo $myLocationInfo|egrep -o '<City>.*</City>'| sed -e 's/^.*<City/<City/' | cut -f2 -d'>'| cut -f1 -d'<'`
myRegionName=`echo $myLocationInfo|egrep -o '<RegionName>.*</RegionName>'| sed -e 's/^.*<RegionName/<RegionName/' | cut -f2 -d'>'| cut -f1 -d'<'`
   
echo "<result>$myCity, $myRegionName - $myCountryCode</result>"
