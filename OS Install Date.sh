#!/bin/bash

# determine the inode birth date for / then convert seconds to "WeekdayName MonthName DD YYYY" format

#eval $(/usr/bin/stat -s /)
#result=$(/bin/date -j -f "%s" "$st_birthtime" "+%a %b %d %Y")
#echo "<result>$result</result>"

# /usr/bin/find / -maxdepth 1 -inum 2 -exec stat -f %B {} \;
# result=$(/bin/date -j -f "%s" "$st_birthtime" "+%Y%m%d")


result=$(head -1 /var/log/install.log | awk -F " " '{print $1, $2}')
echo "<result>$result</result>"